import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';

import 'semantic-ui-css/semantic.min.css';
import {MyDiv} from './my-div.js';
import {MainMenu} from './main-menu.js';
	
class Container extends React.Component {
	state = { selectedSection: 'About me' }
	setSection = (section) => {
		console.log(section);
		this.setState({selectedSection: section});
	}
	render() {
		return (
			<div>
				<MainMenu callbackFromParent={this.setSection}/>
				<MyDiv section={this.state.selectedSection}/>
			</div>
		);
	}
}

ReactDOM.render(
	<Container />,
	document.getElementById('root')
);
	