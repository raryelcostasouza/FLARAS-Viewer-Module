/**
 * FLARAS - Flash Augmented Reality Authoring System
 * --------------------------------------------------------------------------------
 * Copyright (C) 2011-2012 Raryel, Hipolito, Claudio
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * --------------------------------------------------------------------------------
 * Developers:
 * Raryel Costa Souza - raryel.costa[at]gmail.com
 * Hipolito Douglas Franca Moreira - hipolitodouglas[at]gmail.com
 * 
 * Advisor: Claudio Kirner - ckirner[at]gmail.com
 * http://www.ckirner.com/flaras
 * Developed at UNIFEI - Federal University of Itajuba (www.unifei.edu.br) - Minas Gerais - Brazil
 * Research scholarship by FAPEMIG - Fundação de Amparo à Pesquisa no Estado de Minas Gerais
 */

package flaras.controller
{
	import flaras.*;
	import flaras.controller.*;
	import flaras.controller.constants.FolderConstants;
	import flaras.controller.util.*;
	import flaras.view.*;
	import flash.display.*;
	import FTK.*;
	import org.aswing.*;
	
	public class CtrMain
	{		
		private var _ctrPoint:CtrPoint;
		//private var _ctrUserProject:CtrUserProject;
		private var _ctrMarker:CtrMarker;
		//private var _ctrGUI:CtrGUI;
		private var _ctrPointInterWithKbd:CtrPointInteractionWithKbd;
		private var _ctrMirror:CtrMirror;
		//private var _ctrCamera:CtrCamera;
		private var _fmmapp:FLARToolKitMultiMarkerApp;
			
		public function CtrMain(pFMMApp:FLARToolKitMultiMarkerApp)
		{
			var stage:Stage = StageReference.getStage();
			
			//init aswing variables
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.stageFocusRect = false;
			AsWingManager.setRoot(stage);
			
			_fmmapp = pFMMApp;
			this._ctrMarker = new CtrMarker(this);
			this._ctrPoint = new CtrPoint(this);
			//this._ctrUserProject = new CtrUserProject(this);
			this._ctrPointInterWithKbd = new CtrPointInteractionWithKbd(this);
			//this._ctrGUI = new CtrGUI(this);
			this._ctrMirror = new CtrMirror(this, pFMMApp);
			//this._ctrCamera = new CtrCamera(this);
			initUI();
			
			FolderConstants.setFlarasAppCurrentFolder("flarasAppData");
			_ctrPoint.loadProjectData();
			_ctrMarker.loadInteractionMarkerData();
			_ctrMarker.loadRefMarkerData();
		}
		
		private function initUI():void
		{
			var bndMMI:BoundaryMultiMarkerInteraction;
			
			new BoundaryInteractionUI(this);
			bndMMI = new BoundaryMultiMarkerInteraction(this);
		}
		
		/*public function set ctrGUI(ctrGUI:CtrGUI):void
		{
			this._ctrGUI = ctrGUI;
		}
		
		public function get ctrGUI():CtrGUI
		{
			return this._ctrGUI;
		}*/
		
		public function get ctrPoint():CtrPoint
		{
			return this._ctrPoint;
		}
		
		/*public function get ctrUserProject():CtrUserProject
		{
			return this._ctrUserProject;
		}*/
		
		public function get ctrMarker():CtrMarker
		{
			return this._ctrMarker;
		}
		
		public function get ctrPointInterWithKbd():CtrPointInteractionWithKbd 
		{
			return this._ctrPointInterWithKbd;
		}
		
		public function get ctrMirror():CtrMirror
		{
			return this._ctrMirror;
		}
		
		/*public function get ctrCamera():CtrCamera
		{
			return this._ctrCamera;
		}*/
		
		public function get fmmapp():FLARToolKitMultiMarkerApp
		{
			return this._fmmapp;
		}
	}	
}