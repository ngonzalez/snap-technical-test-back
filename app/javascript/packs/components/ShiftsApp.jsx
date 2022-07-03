import React from 'react'
import ReactDOM from 'react-dom'

import axios from 'axios'

import ShiftItems from './ShiftItems'
import ShiftItem from './ShiftItem'
import NewShiftForm from './NewShiftForm'
import Spinner from './Spinner'
import ErrorMessage from './ErrorMessage'
class ShiftsApp extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            shifts: [],
            isLoading: true,
            errorMessage: null,
        }
        this.getShifts = this.getShifts.bind(this)
        this.createShift = this.createShift.bind(this)
        this.handleErrors = this.handleErrors.bind(this)
        this.clearErrors = this.clearErrors.bind(this)
    }
    componentDidMount() {
        this.getShifts()
    }
    getShifts() {
        axios
            .get('/api/v1/shifts')
            .then(response => {
                this.clearErrors()
                this.setState({ isLoading: true })
                const shifts = response.data
                this.setState({ shifts })
                this.setState({ isLoading: false })
            })
            .catch(error => {
                this.setState({ isLoading: true })
                this.setState({
                    errorMessage: {
                        message:
                            'There was an error loading your shifts...',
                    },
                })
            })
    }
    createShift(shift) {
        const shifts = [shift, ...this.state.shifts]
        this.setState({ shifts })
    }
    handleErrors(errorMessage) {
        this.setState({ errorMessage })
    }
    clearErrors() {
        this.setState({
            errorMessage: null,
        })
    }
    getDefaultDate() {
      const today = new Date()
      const yesterday = new Date(today)
      yesterday.setDate(yesterday.getDate() - 1)
      console.log(yesterday.toDateString());
      return yesterday;
    }
    render() {
        return (
            <>
                {this.state.errorMessage && (
                    <ErrorMessage errorMessage={this.state.errorMessage} />
                )}
                {!this.state.isLoading && (
                    <>
                        <NewShiftForm
                            createShift={this.createShift}
                            handleErrors={this.handleErrors}
                            clearErrors={this.clearErrors}
                            defaultDate={this.getDefaultDate()}
                        />
                        <ShiftItems>
                            {this.state.shifts.map(shift => (
                                <ShiftItem
                                    key={shift.id}
                                    shift={shift}
                                    getShifts={this.getShifts}
                                    handleErrors={this.handleErrors}
                                    clearErrors={this.clearErrors}
                                />
                            ))}
                        </ShiftItems>
                    </>
                )}
                {this.state.isLoading && <Spinner />}
            </>
        )
    }
}

document.addEventListener('turbolinks:load', () => {
    const app = document.getElementById('shifts-app')
    app && ReactDOM.render(<ShiftsApp />, app)
})
