import React, { useState } from "react";
import PropTypes from 'prop-types'
import axios from 'axios'
import setAxiosHeaders from './AxiosHeaders'

// datepicker
import DatePicker from "react-datepicker";
import moment from 'moment';
import "react-datepicker/dist/react-datepicker.css";

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
      console.log('handleStartAtChanged');
      console.log(date);
      this.setState({ startAt: date })
      return;
    }

    handleEndAtChanged(date) {
      console.log('handleEndAtChanged');
      console.log(date);
      this.setState({ endAt: date })
      return;
    }

    handleSubmit(e) {
        e.preventDefault()
        setAxiosHeaders()
        axios
            .post('/api/v1/shifts', {
                shift: {
                    start_at: this.state.startAt,
                    end_at: this.state.endAt,
                },
            })
            .then(response => {
                const shift = response.data
                console.log(shift);
                // this.props.createShift(shift)
                // this.props.clearErrors()
            })
            .catch(error => {
                this.props.handleErrors(error)
            })
        e.target.reset()
    }

    render() {
        return (
            <form onSubmit={this.handleSubmit} className="my-3">
                <div className="form-row">
                    <div className="form-group col-md-8">
                        <DatePicker
                          selected={this.state.startAt}
                          onChange={(date) => this.handleStartAtChanged(date)}
                          className="form-control"
                        />
                    </div>
                    <div className="form-group col-md-8">
                        <DatePicker
                          selected={this.state.endAt}
                          onChange={(date) => this.handleEndAtChanged(date)}
                          className="form-control"
                        />
                    </div>
                    <div className="form-group col-md-4">
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

NewShiftForm.propTypes = {
    createShift: PropTypes.func.isRequired,
    handleErrors: PropTypes.func.isRequired,
    clearErrors: PropTypes.func.isRequired,
}
