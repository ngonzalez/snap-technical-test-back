import React from 'react';
import ReactDOM from 'react-dom';
import axios from 'axios';

// errors
import Spinner from './Spinner';
import ErrorMessage from './ErrorMessage';

// csv exports
import CsvExportItems from './CsvExportItems';
import CsvExportItem from './CsvExportItem';
import NewCsvExportForm from './NewCsvExportForm';
import NewXlsExportForm from './NewXlsExportForm';

class CsvExportsApp extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            csvExports: [],
            loading: true,
            errorMessage: null,
            intervals: {},
        };

        // errors
        this.handleErrors = this.handleErrors.bind(this);
        this.clearErrors = this.clearErrors.bind(this);

        // csv exports
        this.getCsvExports = this.getCsvExports.bind(this);
        this.createCsvExport = this.createCsvExport.bind(this);
    }

    componentDidMount() {
        this.getCsvExports();
    }

    handleErrors(message) {
        this.setState({ errorMessage: message });
    }

    clearErrors() {
        this.setState({ errorMessage: null });
    }

    createCsvExport(csvExport) {
        const csvExports = [csvExport, ...this.state.csvExports];
        this.setState({ csvExports: csvExports });
        this.refreshCsvExports();
    }

    refreshCsvExports() {
        const intervalId = new Date().toISOString();
        const callback = this.getCsvExports;
        const count = 0;
        this.state.intervals[intervalId] = setInterval(() => {
            (count <= 3) ? callback() : clearInterval(intervalId)
        }, 5000);
    }

    getCsvExports() {
        axios
            .get('/api/v1/csv_exports')
            .then(response => {
                this.clearErrors();
                this.setState({ csvExports: response.data });
                this.setState({ loading: false });
            })
            .catch(error => {
                this.setState({
                    errorMessage: {
                        message:
                            'Failed to load CSV exports',
                    },
                });
            });
    }

    render() {
        return (
            <>
                {this.state.errorMessage && (
                    <ErrorMessage errorMessage={this.state.errorMessage} />
                )}
                {!this.state.loading && (
                    <>
                        <NewCsvExportForm
                            createCsvExport={this.createCsvExport}
                            handleErrors={this.handleErrors}
                            clearErrors={this.clearErrors}
                        />
                        <NewXlsExportForm
                            createCsvExport={this.createCsvExport}
                            handleErrors={this.handleErrors}
                            clearErrors={this.clearErrors}
                        />
                        <CsvExportItems>
                            {this.state.csvExports.map(csvExport => (
                                <CsvExportItem
                                    key={csvExport.id}
                                    csvExport={csvExport}
                                    getCsvExports={this.getCsvExports}
                                />
                            ))}
                        </CsvExportItems>
                    </>
                )}
                {this.state.loading && <Spinner />}
            </>
        )
    }
}

document.addEventListener('turbolinks:load', () => {
    const app = document.getElementById('csv-exports-app')
    app && ReactDOM.render(<CsvExportsApp />, app)
})
