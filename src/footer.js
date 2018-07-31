import React from 'react';

import './footer.css';

export class Footer extends React.Component {
	constructor(props) {
		super(props);
		this.state = {displayHeart: false};
		this.myRef = React.createRef();
		this.allHearts = [];
		this.allFlows = ['flowOne', 'flowTwo', 'flowThree'];
	}
	
	onMouseOver() {
		this.myRef.current.style.display = 'block';
		const randName = Math.floor((Math.random()*100)+1);
		this.setState({displayHeart: true, randName});
	}

	render() {
		const divClass = `particle part-${this.state.randName}`;
		const randSize = Math.floor(Math.random()*(30-22)+22);
		const randTiming = (Math.random()*(1.3-1.0)+1.0).toFixed(1);
		var randomFlow = this.allFlows[Math.floor(Math.random() * this.allFlows.length)];
		const divStyle = {
			fontSize: `${randSize}px`,
			animation: `${randomFlow} ${randTiming}s linear`,
			display: this.state.displayHeart ? 'block' : 'none'
		};
		
		const heart = ( 
			<div className={divClass} style={divStyle}>
				<i className="fa fa-heart-o"></i>
				<i className="fa fa-heart"></i>
			</div>
		);

		this.allHearts.push(heart);
		setTimeout(() => {
			this.myRef.current.style.display = 'none';
			this.allHearts = [];
		}, randTiming*1000);

		return (
			<div className="footer" >
				<div className="particle-box" ref={this.myRef}>
				{
					this.allHearts.map(heartBlock => (
						heartBlock
					))
				}
				</div>
				<div id="flower-container">
					<svg id="flower-container-svg" viewBox="0 0 512 512" onMouseOver={this.onMouseOver.bind(this)}>
						<path className="stem piece" d="M239.6,272.474c-45.221,9.576-60.881,33.214-66.227,50.121v-94.798h-5.172v135.995
							c-5.108-16.951-20.544-41.177-66.467-50.902c0,0-3.219,60.173,66.467,68.586v115.069c1.715,0.626,3.439,1.231,5.172,1.822V341.033
							C242.812,332.51,239.6,272.474,239.6,272.474z"/>
						<path className="flower piece" d="M192.15,106.696c0,11.798-9.564,53.408-21.363,53.408s-21.364-41.608-21.364-53.408
							s9.566-21.363,21.364-21.363S192.15,94.898,192.15,106.696z"/>
						<path className="flower piece" d="M231.212,140.574c-8.344,8.344-44.528,31.003-52.872,22.659
							c-8.344-8.344,14.317-44.528,22.659-52.872c8.344-8.344,21.869-8.344,30.213,0C239.556,118.705,239.554,132.232,231.212,140.574z"/>
						<path className="flower piece" d="M234.877,192.15c-11.798,0-53.408-9.564-53.408-21.363s41.61-21.363,53.408-21.363 c11.798,0,21.363,9.564,21.363,21.363C256.24,182.586,246.675,192.15,234.877,192.15z"/>
						<path className="flower piece" d="M200.999,231.212c-8.344-8.344-31.003-44.528-22.659-52.872c8.344-8.344,44.528,14.317,52.872,22.659 c8.344,8.344,8.344,21.869,0,30.213C222.868,239.554,209.342,239.554,200.999,231.212z"/>
						<path className="flower piece" d="M149.423,234.877c0-11.798,9.564-53.408,21.363-53.408s21.363,41.61,21.363,53.408
							s-9.564,21.363-21.363,21.363C158.989,256.24,149.423,246.675,149.423,234.877z"/>
						<path className="flower piece" d="M110.363,200.999c8.344-8.344,44.528-31.003,52.872-22.659c8.344,8.344-14.317,44.528-22.659,52.872
							c-8.344,8.344-21.869,8.344-30.213,0C102.019,222.868,102.019,209.342,110.363,200.999z"/>
						<path className="flower piece" d="M106.696,149.423c11.798,0,53.408,9.564,53.408,21.363s-41.61,21.363-53.408,21.363
							s-21.363-9.563-21.363-21.361S94.898,149.423,106.696,149.423z"/>
						<path className="flower piece" d="M140.574,110.363c8.344,8.344,31.003,44.528,22.659,52.872
							c-8.344,8.344-44.528-14.317-52.872-22.659c-8.344-8.342-8.344-21.869,0-30.213S132.232,102.019,140.574,110.363z"/>
						<circle id="center-daisy" className="flower central piece" cx="170.787" cy="170.787" r="32.046"/>
					</svg>
				</div>
				<div>
					Of course, made with <i className="fa fa-heart" style={{color: '#e25555'}}></i> and <a href="https://reactjs.org/" target="_blank" rel="noopener noreferrer">ReactJS</a>
				</div>
			</div>
		);
	}
}
