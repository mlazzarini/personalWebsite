import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';

import 'semantic-ui-css/semantic.min.css';
import {Content} from './content';
import {MainMenu} from './main-menu';
	
class Container extends React.Component {
	state = {
		selectedSection: 'home'
	}
	setSection = section => {
		this.setState({selectedSection: section});
	}
	render() {
		return (
			<div>
				<MainMenu onClick={this.setSection}/>
				<Content section={this.state.selectedSection}/>
			</div>
		);
	}
}

ReactDOM.render(
	<Container />,
	document.getElementById('root')
);
	