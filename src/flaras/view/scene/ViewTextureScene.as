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

package flaras.view.scene 
{
	import flaras.controller.*;
	import flaras.controller.constants.*;
	import flaras.controller.io.*;
	import flaras.model.*;
	import flaras.model.scene.*;
	import flaras.view.marker.*;
	import flash.events.*;
	import flash.net.*;
	import org.papervision3d.core.math.*;
	import org.papervision3d.events.FileLoadEvent;
	import org.papervision3d.materials.*;
	import org.papervision3d.objects.*;
	import org.papervision3d.objects.primitives.*;

	public class ViewTextureScene extends ViewFlarasScene
	{		
		private var _textureScene:TextureScene;
		
		public function ViewTextureScene(textureScene:TextureScene, pCtrMain:CtrMain) 
		{
			super(this, textureScene, pCtrMain);
			_textureScene = textureScene;
		}
		
		override public function showScene(playAudio:Boolean):void 
		{
			if (_obj3D)
			{
				_obj3D.visible = true;
			}
			else
			{
				load();
			}
			super.showScene(playAudio);
		}
		
		override public function hideScene():void
		{
			super.hideScene();
			if (_obj3D)
			{
				_obj3D.visible = false;
			}
		}
		
		public function load():void
		{
			var plane:Plane;
			var bfm:BitmapFileMaterial;
			var urlLoader:URLLoader;
			
			bfm = new BitmapFileMaterial(FolderConstants.getFlarasAppCurrentFolder() + "/" + _textureScene.getTextureFilePath());
			bfm.addEventListener(FileLoadEvent.LOAD_COMPLETE, onComplete);
			bfm.addEventListener(FileLoadEvent.LOAD_ERROR, onIOError);
			
			bfm.interactive = true;
			bfm.doubleSided = true;
			
			plane = new Plane(bfm, _textureScene.getWidth(), _textureScene.getHeight());
		
			_obj3D = plane;
			
			//set position, rotation and scale
			setObj3DProperties(_textureScene, _obj3D);
			setMirrorScaleFactor(CtrMirror.MIRRORED_SCALE_FACTOR);
			
			MarkerNodeManager.addObj2MarkerNode(_obj3D, CtrMarker.REFERENCE_MARKER, null);
		}
		
		override public function unLoad():void
		{
			if (_obj3D)
			{
				super.unLoad();
				
				MarkerNodeManager.removeObjFromMarkerNode(_obj3D, CtrMarker.REFERENCE_MARKER);
				_obj3D = null;
			}			
		}
		
		override public function destroy():void 
		{
			unLoad();
			super.destroy();
			_textureScene = null;
		}
		
		private function onComplete(e:Event):void
		{
			e.target.removeEventListener(FileLoadEvent.LOAD_COMPLETE, onComplete);
			e.target.removeEventListener(FileLoadEvent.LOAD_ERROR, onIOError);
			
			setupMouseInteraction();
		}
		
		private function onIOError(e:Event):void
		{
			ErrorHandler.onIOError("ViewTextureScene", FolderConstants.getFlarasAppCurrentFolder() + "/" + _textureScene.getTextureFilePath());
		}	
	}

}