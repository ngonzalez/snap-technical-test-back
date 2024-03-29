import React, { useState } from "react";
import PropTypes from 'prop-types';
import axios from 'axios';
import setAxiosHeaders from './AxiosHeaders';
import DatePicker from "react-datepicker"; // react-datepicker https://github.com/Hacker0x01/react-datepicker
import "react-datepicker/dist/react-datepicker.css";
import moment from 'moment';

class NewShiftForm extends React.Component {
    constructor(props) {
        super(props)
        this.handleSubmit = this.handleSubmit.bind(this);
        this.state = {
            startAt: this.props.defaultDate,
            endAt: this.props.defaultDate,
        };
    }

    handleStartAtChanged(date) {
        this.setState({ startAt: date });
    }

    handleEndAtChanged(date) {
        this.setState({ endAt: date });
    }

    handleSubmit(e) {
        e.preventDefault();
        setAxiosHeaders();
        axios
            .post('/api/v1/shifts', {
                shift: {
                    start_at: this.state.startAt,
                    end_at: this.state.endAt,
                },
            })
            .then(response => {
                const shift = response.data;
                this.props.createShift(shift);
                this.props.clearErrors();
            })
            .catch(error => {
                this.props.handleErrors(error);
            })
        e.target.reset()
    }

    render() {
        return (
            <form onSubmit={this.handleSubmit}>
                <div className="form-row">
                    <div className="form-group m-1 p-1">
                        <DatePicker
                          selected={this.state.startAt}
                          onChange={(date) => this.handleStartAtChanged(date)}
                          className="form-control"
                          showTimeSelect
                          timeFormat="HH:mm"
                          timeIntervals={30}
                          dateFormat="yyyy-MM-dd h:mm"
                        />
                    </div>
                    <div className="form-group m-1 p-1">
                        <DatePicker
                          selected={this.state.endAt}
                          onChange={(date) => this.handleEndAtChanged(date)}
                          className="form-control"
                          showTimeSelect
                          timeFormat="HH:mm"
                          timeIntervals={30}
                          dateFormat="yyyy-MM-dd h:mm"
                        />
                    </div>
                    <div className="form-group m-1 p-1">
                        <button className="btn btn-outline-success btn-block">
                            Add Shift
                        </button>
                    </div>
                </div>
            </form>
        )
    }
}

export default NewShiftForm

// Typechecking With PropTypes
// https://reactjs.org/docs/typechecking-with-proptypes.html
NewShiftForm.propTypes = {
    createShift: PropTypes.func.isRequired,
    handleErrors: PropTypes.func.isRequired,
    clearErrors: PropTypes.func.isRequired,
    defaultDate: PropTypes.object.isRequired,
}
