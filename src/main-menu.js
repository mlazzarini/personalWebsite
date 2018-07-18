import React from 'react';
import { Menu } from 'semantic-ui-react/dist/commonjs'

import '../node_modules/bootstrap/dist/css/bootstrap.min.css';
import { Button } from 'react-bootstrap';

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
				<Button bsStyle="primary" onClick={() => this.handleItemClick('projects')}>Projects</Button>
				<Button bsStyle="primary" onClick={() => this.handleItemClick('contacts')}>Contact me</Button>
				<Button bsStyle="primary" onClick={() => this.handleItemClick('reads')}>Read it!</Button>
			</div>
		)
	}
}
