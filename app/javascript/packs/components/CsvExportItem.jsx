import React from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import setAxiosHeaders from './AxiosHeaders'

class CsvExportItem extends React.Component {
    constructor(props) {
        super(props);
        this.state = {};
        this.handleDestroy = this.handleDestroy.bind(this);
    }

    handleDestroy() {
        setAxiosHeaders();
        const confirmation = confirm('Are you sure?');
        if (confirmation) {
            axios
                .delete(`/api/v1/csv_exports/${this.props.csvExport.id}`)
                .then(response => {
                    this.props.getCsvExports();
                })
                .catch(error => {
                    console.debug(error);
                });
        }
    }

    render() {
        const { csvExport } = this.props.csvExport;
        return (
            <tr>
                <td>
                    {this.props.csvExport.user_id}
                </td>
                <td>
                    {this.props.csvExport.created_at}
                </td>
                <td>
                    {this.props.csvExport.file_name}
                </td>
                <td className="text-right">
                    <button
                        onClick={this.handleDestroy}
                        className="btn btn-outline-danger"
                    >
                        Delete
                    </button>
                </td>
            </tr>
        )
    }
}

export default CsvExportItem

CsvExportItem.propTypes = {
    csvExport: PropTypes.object.isRequired,
    getCsvExports: PropTypes.func.isRequired,
};
