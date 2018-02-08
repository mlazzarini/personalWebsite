import React, { Component } from 'react'
import { Menu } from 'semantic-ui-react'

export class MainMenu extends Component {
	constructor(props) {
		super(props)
		this.handleItemClick = this.handleItemClick.bind(this)
	}

	handleItemClick(e, {name}) {
		this.props.callbackFromParent(name);
	}
	render() {
		return (
			<Menu secondary>
				<Menu.Item name='About me' onClick={this.handleItemClick} />
				<Menu.Item name='Projects' onClick={this.handleItemClick} />
				<Menu.Item name='Contact me' onClick={this.handleItemClick} />
			</Menu>
		)
	}
}