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
				<div className="content" >
					<Projects />
				</div>
			);
			case 'contacts':
			return (
				<div className="content" >
					<ContactMe />
				</div>
			);
			case 'reads':
				return (
					<div className="content" >
						<ReadIt />
					</div>
				);
			default:
				return (
					<div className="content" >
					</div>
				);
		}
	}
}
