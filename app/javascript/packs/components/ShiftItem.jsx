import React from 'react'
import PropTypes from 'prop-types'

import _ from 'lodash'
import axios from 'axios'
import setAxiosHeaders from './AxiosHeaders'
class ShiftItem extends React.Component {
    constructor(props) {
        super(props)
        this.state = {}
        this.handleDestroy = this.handleDestroy.bind(this)
        this.handleChange = this.handleChange.bind(this)
        this.updateShift = this.updateShiftItem.bind(this)
        this.startAtRef = React.createRef()
        this.endAtRef = React.createRef()
        this.path = `/api/v1/shifts/${this.props.shift.id}`
    }
    handleChange() {
        this.updateShift()
    }
    updateShift = _.debounce(() => {
        setAxiosHeaders()
        axios
            .put(this.path, {
                shift: {
                    start_at: this.startAtRef.current.value,
                    end_at: this.endAtRef.current.value,
                },
            })
            .then(() => {
                this.props.clearErrors()
            })
            .catch(error => {
                this.props.handleErrors(error)
            })
    }, 1000)
    handleDestroy() {
        setAxiosHeaders()
        const confirmation = confirm('Are you sure?')
        if (confirmation) {
            axios
                .delete(this.path)
                .then(response => {
                    this.props.getShifts()
                })
                .catch(error => {
                    console.debug(error)
                })
        }
    }
    render() {
        const { shift } = this.props
        return (
            <tr>
                <td>
                    <input
                        type="text"
                        defaultValue={shift.startAt}
                        onChange={this.handleChange}
                        ref={this.startAtRef}
                        className="form-control"
                        id={`shift__startAt-${shift.id}`}
                    />
                </td>
                <td>
                    <input
                        type="text"
                        defaultValue={shift.startAt}
                        onChange={this.handleChange}
                        ref={this.endAtRef}
                        className="form-control"
                        id={`shift__endAt-${shift.id}`}
                    />
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

export default ShiftItem

ShiftItem.propTypes = {
    shift: PropTypes.object.isRequired,
    getShifts: PropTypes.func.isRequired,
    clearErrors: PropTypes.func.isRequired,
}
