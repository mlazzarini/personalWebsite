import React from 'react';
import { Menu } from 'semantic-ui-react/dist/commonjs'

export class MainMenu extends React.Component {
	constructor(props) {
		super(props)
		this.handleItemClick = this.handleItemClick.bind(this)
	}

	handleItemClick(e, {title}) {
		this.props.onClick(title);
	}
	
	render() {
		return (
			<Menu secondary>
				<Menu.Item name='Projects' title='projects' onClick={this.handleItemClick} />
				<Menu.Item name='Contact me' title='contacts' onClick={this.handleItemClick} />
				<Menu.Item name='Read it!' title='reads' onClick={this.handleItemClick} />
			</Menu>
		)
	}
}
