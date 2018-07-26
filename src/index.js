import React from 'react';
import ReactDOM from 'react-dom';

import '../node_modules/bootstrap/dist/css/bootstrap.min.css';
import './main.css';
import {MainMenu} from './main-menu';
import {Content} from './content';
import {Footer} from './footer';
	
class Container extends React.Component {
	state = {
		selectedSection: 'home'
	}
	setSection = section => {
		this.setState({selectedSection: section});
	}
	componentWillMount() {
		document.body.style.backgroundColor = "#add8e6";
		document.body.style.color = "#fff";
		document.body.style.textAlign = "center";
		document.body.style.fontSize = "2em";
		document.body.style.lineHeight = "2.5em";
		document.body.style.margin = "0";
		document.body.style.height = "100%";

	}
	componentWillUnmount() {
		document.body.style.backgroundColor = null;
		document.body.style.color = null;
		document.body.style.textAlign = null;
		document.body.style.fontSize = null;
		document.body.style.lineHeight = null;
		document.body.style.margin = null;
		document.body.style.height = null;
	}
	render() {
		return (
			<div className="container">
				<div className="header">
					<span className="name evidence">Margherita Lazzarini</span> 
					<br/>
					<span className="evidence">Software developer.</span>
					<MainMenu onClick={this.setSection}/>
				</div>
				<Content section={this.state.selectedSection}/>
				<Footer />
			</div>
		);
	}
}

ReactDOM.render(
	<Container />,
	document.getElementById('root')
);
	