import React from 'react';

export class ContactMe extends React.Component {
	render(){
		return (
			<div id="contacts">
				<span  className="about">Here's my <a href="https://it.linkedin.com/in/margherita-lazzarini-04380a60" target="blank">LinkedIn page</a><br/>
				Here you can download my <a target="blank" href="./data/onePageCv.pdf"> english CV </a></span><br/>
				<span className="about">E-mail: margherita.lazzarini@gmail.com</span><br/>
				<span className="about">Skype ID: margheritalazzariniunibo</span>
				<br/><br/>
			</div>
		);
	}
}
