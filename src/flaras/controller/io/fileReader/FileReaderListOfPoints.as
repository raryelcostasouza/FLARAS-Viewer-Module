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

package flaras.controller.io.fileReader
{
	import flaras.controller.*;
	import flaras.controller.io.*;
	import flaras.model.point.RefScene2Attract;
	import flash.errors.*;
	import flash.events.*;
	import flash.net.*;
	import org.papervision3d.core.math.*;
	
	public class FileReaderListOfPoints extends FileReader
	{
		private var _filePath:String;
		
		public function FileReaderListOfPoints(pFilePath:String, pObjCtrPoint:CtrPoint)
		{
			super(pObjCtrPoint);
			_filePath = pFilePath;
			readFile(pFilePath);
		}
		
		private function readFile(pFilePath:String):void
		{
			var fileLoader:URLLoader = new URLLoader(new URLRequest(pFilePath));
			
			fileLoader.addEventListener(Event.COMPLETE, onComplete);
            fileLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError); 
            fileLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError); 
		}
		
		private function onComplete(e:Event):void
		{			
			var label:String;
			var moveInteractionForScenes:Boolean;
			var type:String;
			var idNumber:int;
			var listOfScenes2Attract:Vector.<RefScene2Attract>;
			
			e.target.removeEventListener(Event.COMPLETE, onComplete);
			e.target.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			e.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			
			aXMLFile = XML(e.target.data);
			
			for each (var point:XML in aXMLFile.point) 
			{
				if (point.label == undefined)
				{
					label = "";
				}
				else
				{
					label = point.label;
				}
				
				if (point.moveInteractionForScenes == undefined)
				{
					moveInteractionForScenes = false;
				}
				else
				{
					moveInteractionForScenes = Boolean(parseInt(point.moveInteractionForScenes));
				}
				
				if (point.idNumber == undefined)
				{
					idNumber = -1;
				}
				else
				{
					idNumber = parseInt(point.idNumber);
				}
				
				if (point.type == undefined || point.type == "default")
				{
					aObjCtrPoint.addPointFromXML(new Number3D(point.position.x, point.position.y, point.position.z), label, moveInteractionForScenes, idNumber);
				}
				else
				{
					//if is an attraction/repulsion point
					listOfScenes2Attract = new Vector.<RefScene2Attract>();
					for each (var refScene2Attract:XML in point.listOfScenes2Attract.refScene2Attract)
					{
						listOfScenes2Attract.push(new RefScene2Attract(refScene2Attract.pointIndex, refScene2Attract.sceneIDNumber))
					}
					
					aObjCtrPoint.addPointAttractRepulseFromXML(new Number3D(point.position.x, point.position.y, point.position.z), label, point.attractionSphereRadius, true, listOfScenes2Attract, idNumber);
				}				
			}			
			aObjCtrPoint.finishedReadingListOfPoints();
		}	
		
		private function onIOError(e:Event):void
		{
			ErrorHandler.onIOError("FileReaderListOfPoints", _filePath);
		}
		
		private function onSecurityError(e:Event):void
		{
			ErrorHandler.onSecurityError("FileReaderListOfPoints", _filePath);
		}
	}
	
}