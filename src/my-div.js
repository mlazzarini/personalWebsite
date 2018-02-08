import React from 'react';

export class MyDiv extends React.Component {
	constructor(props) {
		super(props);
	} 
	render(){
		return (
			<p> Selected section now is {this.props.section} </p>
		);
	}
}