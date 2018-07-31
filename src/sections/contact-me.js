import React from 'react';

import cv from '../data/CV_one_page_Lazzarini.pdf';

export class ContactMe extends React.Component {
	render(){
		return (
			<div id="contacts">
				<span  className="about">Here's my <a href="https://it.linkedin.com/in/margherita-lazzarini-04380a60" target="blank" rel="noopener noreferrer">LinkedIn page</a><br/>
				Here you can download my <a target="blank" rel="noopener noreferrer" href={cv}> english CV </a></span><br/>
				<span className="about"><span className="highlighted">E-mail:</span> margherita.lazzarini@gmail.com</span><br/>
				<span className="about"><span className="highlighted">Skype ID:</span> margheritalazzariniunibo</span>
				<br/><br/>
			</div>
		);
	}
}
