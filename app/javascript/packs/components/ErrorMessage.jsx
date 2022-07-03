import React from 'react'
import PropTypes from 'prop-types'

import _ from 'lodash'

const ErrorMessage = props => {
    const message = _.get(props.errorMessage, 'message', null)
    if (message) {
        return (
            <div className="alert alert-danger" role="alert">
                <p className="mb-0">{message}</p>
            </div>
        )
    }
}

export default ErrorMessage

ErrorMessage.propTypes = {
    errorMessage: PropTypes.object.isRequired,
}
