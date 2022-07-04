import React from 'react'
import PropTypes from 'prop-types'

class CsvExportItems extends React.Component {
    constructor(props) {
        super(props)
    }
    render() {
        return (
            <>
                <hr />
                <div className="table-responsive">
                    <table className="table">
                        <thead>
                            <tr>
                                <th scope="col">User ID</th>
                                <th scope="col">Created At</th>
                                <th scope="col">Download</th>
                                <th scope="col" className="text-right">
                                    Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody>{this.props.children}</tbody>
                    </table>
                </div>
            </>
        )
    }
}
export default CsvExportItems
