import React from 'react';

import { Table, Image } from 'react-bootstrap';
import tesi from '../data/lazzarini_margherita_tesi.pdf';
import relazioneSM from '../data/relazioneSistemiMW.pdf';
import vscodelogo from '../images/vscodeLogo.png';
import scena from '../images/scena.png';

export class Projects extends React.Component {
	render(){
		return (
			<div>
				<p>Here's my <a href={tesi} target="_blank" rel="noopener noreferrer">master thesis</a> [italian] and <a href="https://github.com/mlazzarini" target="_blank" rel="noopener noreferrer">my GitHub page</a>.</p>
				<p>Sometimes I say something on <a target="_blank" rel="noopener noreferrer" href="https://medium.com/@mlazzarini">Medium</a>.</p>
				<Table striped>
				<tbody>
					<tr>
						<td width="40%"><Image src={vscodelogo} responsive /></td>
						<td><span class="highlighted">Pair programming .vscode extension</span><br/>
						IDE extension to support pair programming.<br />
						See <a href="https://marketplace.visualstudio.com/items?itemName=mlazzarini.pair-programming-timer">here</a>
						</td>
					</tr>
					<tr>
						<td colSpan="2">Maintenance for <a className="highlighted" href="http://www.hangovertheworld.com/" target="_blank" rel="noopener noreferrer">Hangover the world</a>, travel blog of a friend.
						</td>
					</tr>
					<tr>
						<td><Image src={scena} thumbnail /></td>
						<td>A 3D Blender rendering for the computer graphic course using ray tracing effect.</td>
					</tr>
					<tr>
						<td colSpan="2"><span class="highlighted">AJBoss app using Opennebula tool, 2014.</span><br />Configuration of a cluster of virtual machines using Opennebula and deployment of a JBoss simple stateful app to test fault tolerance.<br />See <a href={relazioneSM} target="_blank" rel="noopener noreferrer">here</a> for full description [italian]. In collaboration with Federico Montori.</td>
					</tr>
					<tr>
						<td colSpan="2"><span class="highlighted">Proxy miniHttp with prefetching, 2012</span><br />A simple HTTP proxy working on a subset of HTML. Developed in C with pthread to serve multiple HTTP requests. <a href="https://code.google.com/archive/p/prefetching/" target="_blank" rel="noopener noreferrer">Googlecode link</a>. In collaboration with Simone Rondelli.<br /></td>
					</tr>
				</tbody>
				</Table>
			</div>
		);
	}
}
