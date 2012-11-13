package flaras.controller 
{
	import flaras.model.point.*;
	import flaras.view.gui.*;
	import flaras.view.scene.*;
	
	public class CtrInteraction 
	{		
		private var _ctrMain:CtrMain;
		private var _viewGUIInteraction:ViewGUIInteraction;
		
		public function CtrInteraction(ctrMain:CtrMain) 
		{
			this._ctrMain = ctrMain;
			_viewGUIInteraction = new ViewGUIInteraction(this);
		}
		
		public function getCtrMain():CtrMain
		{
			return _ctrMain;
		}
		
		public function getViewGUIInteraction():ViewGUIInteraction
		{
			return _viewGUIInteraction;
		}
		
		public function mouseClickPoint(p:Point):void
		{
			if (_viewGUIInteraction.isInspectionSelected())
			{
				_ctrMain.ctrPoint.inspectPoint(p);
			}
		}
		
		public function mouseClickScene(p:Point, vfs:ViewFlarasScene):void
		{
			if (_viewGUIInteraction.isInspectionSelected())
			{
				_ctrMain.ctrPoint.inspectPoint(p);
			}
			else if (_viewGUIInteraction.isControlForwardSelected())
			{
				_ctrMain.ctrPoint.controlPoint(p, CtrMarker.CONTROL_FORWARD);
			}
			else if (_viewGUIInteraction.isControlBackwardSelected())
			{
				_ctrMain.ctrPoint.controlPoint(p, CtrMarker.CONTROL_BACKWARD);
			}
			else if (_viewGUIInteraction.isMoveXYSelected())
			{
				if (p.isMoveInteractionForScenes())
				{
					vfs.setupMoveXYInteraction();
				}
				else
				{
					MessageWindow.messageMoveInteractionNotAllowed();
				}
			}
			else if (_viewGUIInteraction.isMoveZSelected())
			{
				/*if (p.isMoveInteractionForScenes())
				{
					vfs.setupMoveZInteraction();
				}
				else
				{
					MessageWindow.messageMoveInteractionNotAllowed();
				}*/
			}
			else if (_viewGUIInteraction.isResetSelected())
			{
				vfs.resetScenePosition();
			}
		}
		
		public function resetAllScenesPosition():void
		{
			_ctrMain.ctrPoint.resetAllScenesPosition();
		}
	}
}