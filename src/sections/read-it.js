import React from 'react';

import { Table } from 'react-bootstrap';
import './read-it.css';

export class ReadIt extends React.Component {
	render(){
		return (
			<div>
				<p>Here's a list of interesting books/articles/stuff I've read and I recommend!</p>
				<Table striped>
				<tbody>
					<tr>
						<td>pic 1</td>
						<td>The pragmatic programmer
							<br/>
							Description of the book, blah blahh..
							<br/>
							<a href="#"> Link to amazon or boh</a>
						</td>
					</tr>
					<tr>
					<td>pic 2</td>
					<td>Jacob</td>
					</tr>
					<tr>
					<td colSpan="2">Larry the Bird</td>
					</tr>
				</tbody>
				</Table>
			</div>
		);
	}
}
