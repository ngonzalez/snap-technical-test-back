import React, { useState } from "react";
import PropTypes from 'prop-types';
import axios from 'axios';
import setAxiosHeaders from './AxiosHeaders';

class NewXlsExportForm extends React.Component {
    constructor(props) {
        super(props)
        this.handleSubmit = this.handleSubmit.bind(this);
    }

    handleSubmit(e) {
        e.preventDefault();
        setAxiosHeaders();
        axios
            .post('/api/v1/csv_exports', {
                csv_export: {
                    format_name: 'xls',
                },
            })
            .then(response => {
                const csvExport = response.data;
                this.props.createCsvExport(csvExport);
                this.props.clearErrors();
            })
            .catch(error => {
                this.props.handleErrors(error);
            })
        e.target.reset()
    }

    render() {
        return (
            <form onSubmit={this.handleSubmit} className="my-3">
                <div className="form-row">
                    <div className="form-group col-md-4">
                        <button className="btn btn-outline-success btn-block">
                            Create XLS Export
                        </button>
                    </div>
                </div>
            </form>
        )
    }
}

export default NewXlsExportForm

NewXlsExportForm.propTypes = {
    createCsvExport: PropTypes.func.isRequired,
    handleErrors: PropTypes.func.isRequired,
    clearErrors: PropTypes.func.isRequired,
}
