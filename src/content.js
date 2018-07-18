import React from 'react';
import {Projects} from './sections/projects';
import {ContactMe} from './sections/contact-me';
import {ReadIt} from './sections/read-it';

export class Content extends React.Component {
	constructor(props) {
		super(props);
	}

	render(){
		switch(this.props.section) {
			case 'projects':
			return (
				<div>
					<p> Selected section now is {this.props.section} </p>
					<Projects />
				</div>
			);
			case 'contacts':
			return (
				<div>
					<p> Selected section now is {this.props.section} </p>
					<ContactMe />
				</div>
			);
			case 'reads':
				return (
					<div>
						<p> Selected section now is {this.props.section} </p>
						<ReadIt />
					</div>
				);
			default:
				return (
					<div>
						<p> Selected section now is {this.props.section} </p>
					</div>
				);
		}
	}
}
