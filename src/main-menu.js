import React from 'react';

import '../node_modules/bootstrap/dist/css/bootstrap.min.css';
import { Button } from 'react-bootstrap';
import './main-menu.css';

export class MainMenu extends React.Component {
	constructor(props) {
		super(props)
		this.handleItemClick = this.handleItemClick.bind(this);
	}

	handleItemClick(e) {
		this.props.onClick(e);
	}
	
	render() {
		return (
			<div>
				<Button bsStyle="primary" bsSize="large" onClick={() => this.handleItemClick('projects')}>Projects</Button>
				<Button bsStyle="primary" bsSize="large" onClick={() => this.handleItemClick('contacts')}>Contact me</Button>
				<Button bsStyle="primary" bsSize="large" onClick={() => this.handleItemClick('reads')}>Read it!</Button>
			</div>
		)
	}
}
