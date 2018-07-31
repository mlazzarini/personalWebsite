import React from 'react';

import { Table, Image } from 'react-bootstrap';
import './read-it.css';

import pragmaticProgrammerLogo from '../images/pragmatic_programmer.jpg';
import buildingMaintainableLogo from '../images/building_maintainable.gif';

export class ReadIt extends React.Component {
	render() {
		return (
			<div>
				<p>Here's a list of interesting books/articles/stuff I've read and I recommend!</p>
				<Table striped>
				<tbody>
					<tr>
						<td><Image src={pragmaticProgrammerLogo} thumbnail /></td>
						<td>The Pragmatic Programmer: From Journeyman to Master</td>
					</tr>
					<tr>
						<td colSpan="2"><a href="https://www.se.rit.edu/~tabeec/RIT_441/Resources_files/How%20To%20Write%20Unmaintainable%20Code.pdf" target="blank" rel="noopener noreferrer">How To Write Unmaintainable Code article</a></td>
					</tr>
					<tr>
						<td><Image src={buildingMaintainableLogo} thumbnail /></td>
						<td>Building Maintainable Software book. Here's my <a href="https://medium.com/@mlazzarini/10-maintainable-software-guidelines-94abf872126a" target="blank" rel="noopener noreferrer">book review</a> on Medium.</td>
					</tr>
				</tbody>
				</Table>
			</div>
		);
	}
}
