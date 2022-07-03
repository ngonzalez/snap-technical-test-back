import React from 'react'
import PropTypes from 'prop-types'

import axios from 'axios'
import setAxiosHeaders from './AxiosHeaders'
class ShiftForm extends React.Component {
    constructor(props) {
        super(props)
        this.handleSubmit = this.handleSubmit.bind(this)
        this.startAtRef = React.createRef()
        this.endAtRef = React.createRef()
    }

    handleSubmit(e) {
        e.preventDefault()
        setAxiosHeaders()
        axios
            .post('/api/v1/shifts', {
                shift: {
                    start_at: this.startAtRef.current.value,
                    end_at: this.endAtRef.current.value,
                },
            })
            .then(response => {
                const shift = response.data
                this.props.createShift(shift)
                this.props.clearErrors()
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
                        <input
                            type="text"
                            name="start_at"
                            ref={this.startAtRef}
                            required
                            className="form-control"
                            id="start_at"
                            placeholder="Start At"
                        />
                    </div>
                    <div className="form-group col-md-8">
                        <input
                            type="text"
                            name="end_at"
                            ref={this.endAtRef}
                            required
                            className="form-control"
                            id="end_at"
                            placeholder="End At"
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

export default ShiftForm

ShiftForm.propTypes = {
    createShift: PropTypes.func.isRequired,
    handleErrors: PropTypes.func.isRequired,
    clearErrors: PropTypes.func.isRequired,
}
