import React from 'react'
import PropTypes from 'prop-types'
import axios from 'axios'
import setAxiosHeaders from './AxiosHeaders'

class ShiftItem extends React.Component {
    constructor(props) {
        super(props)
        this.state = {}
        this.handleDestroy = this.handleDestroy.bind(this)
    }
    handleDestroy() {
        setAxiosHeaders()
        const confirmation = confirm('Are you sure?')
        if (confirmation) {
            axios
                .delete(`/api/v1/shifts/${this.props.shift.id}`)
                .then(response => {
                    this.props.getShifts()
                })
                .catch(error => {
                    console.debug(error)
                })
        }
    }
    render() {
        const { shift } = this.props.shift;
        return (
            <tr>
                <td>
                    {this.props.shift.user_id}
                </td>
                <td>
                    {this.props.shift.start_at}
                </td>
                <td>
                    {this.props.shift.end_at}
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

// Typechecking With PropTypes
// https://reactjs.org/docs/typechecking-with-proptypes.html
ShiftItem.propTypes = {
    shift: PropTypes.object.isRequired,
    getShifts: PropTypes.func.isRequired,
}
