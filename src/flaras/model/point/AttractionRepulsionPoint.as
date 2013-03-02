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

package flaras.model.point 
{
	import org.papervision3d.core.math.*;
	public class AttractionRepulsionPoint extends Point
	{
		private var _listOfScenes2Attract:Vector.<RefScene2Attract>;
		private var _attractionSphereRadius:Number;
		
		public function AttractionRepulsionPoint(pIndexPoint:uint, pPosition:Number3D, pLabel:String, pAttractionSphereRadius:Number, pIDNumber:uint ) 
		{
			super(pIndexPoint, pPosition, pLabel, false, pIDNumber);
			
			_attractionSphereRadius = pAttractionSphereRadius;
			_listOfScenes2Attract = new Vector.<RefScene2Attract>();
		}		
		
		override public function destroy():void
		{
			super.destroy();
			_listOfScenes2Attract = null;
		}
		
		public function setListOfScenes2Attract(pListOfScenes2Attract:Vector.<RefScene2Attract>):void
		{
			_listOfScenes2Attract = pListOfScenes2Attract;
		}
		
		public function getListOfScenes2Attract():Vector.<RefScene2Attract>
		{
			return _listOfScenes2Attract;
		}
		
		public function getAttractionSphereRadius():Number
		{
			return _attractionSphereRadius;
		}
		
		public function setAttractionSphereRadius(pAttractionSphereRadius:Number):void
		{
			_attractionSphereRadius = pAttractionSphereRadius;
		}		
	}
}