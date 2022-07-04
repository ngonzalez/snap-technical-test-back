import React from 'react';
import ReactDOM from 'react-dom';
import axios from 'axios';

// errors
import Spinner from './Spinner';
import ErrorMessage from './ErrorMessage';

// shifts
import ShiftItems from './ShiftItems';
import ShiftItem from './ShiftItem';
import NewShiftForm from './NewShiftForm';

class ShiftsApp extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            shifts: [],
            loading: true,
            errorMessage: null,
        };

        // errors
        this.handleErrors = this.handleErrors.bind(this);
        this.clearErrors = this.clearErrors.bind(this);

        // shifts
        this.getShifts = this.getShifts.bind(this);
        this.createShift = this.createShift.bind(this);
    }

    componentDidMount() {
        this.getShifts();
    }

    getShifts() {
        axios
            .get('/api/v1/shifts')
            .then(response => {
                this.clearErrors();
                this.setState({ shifts: response.data });
                this.setState({ loading: false });
            })
            .catch(error => {
                this.setState({
                    errorMessage: {
                        message:
                            'Failed to load shifts',
                    },
                });
            });
    }

    handleErrors(message) {
        this.setState({ errorMessage: message });
    }

    clearErrors() {
        this.setState({ errorMessage: null });
    }

    createShift(shift) {
        const shifts = [shift, ...this.state.shifts];
        this.setState({ shifts: shifts });
    }

    render() {
        return (
            <>
                {this.state.errorMessage && (
                    <ErrorMessage errorMessage={this.state.errorMessage} />
                )}
                {!this.state.loading && (
                    <>
                        <NewShiftForm
                            createShift={this.createShift}
                            handleErrors={this.handleErrors}
                            clearErrors={this.clearErrors}
                            defaultDate={new Date()}
                        />
                        <ShiftItems>
                            {this.state.shifts.map(shift => (
                                <ShiftItem
                                    key={shift.id}
                                    shift={shift}
                                    getShifts={this.getShifts}
                                />
                            ))}
                        </ShiftItems>
                    </>
                )}
                {this.state.loading && <Spinner />}
            </>
        )
    }
}

document.addEventListener('turbolinks:load', () => {
    const app = document.getElementById('shifts-app')
    app && ReactDOM.render(<ShiftsApp />, app)
})
