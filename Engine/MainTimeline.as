/**
	-----------------------------------
	| ALL CREDITS TO AQWORLDS (AQ.COM)|
	|        GRAB MADE BY RAILY 	  |
	|         GRAB MADE WITH <3    	  |
	|         MADE IN CHERNOBYL       |
	|    PLEASE, KATH SUCK MY DICK    |
	-----------------------------------
		                                  **/
package Engine
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;

    dynamic public class MainTimeline extends MovieClip
    {
        public var mcLoading:MovieClip;
        public var sFile:Object;
        public var sTitle:Object;
        public var sBG:String;
        public var sURL:String;
        public var isWeb:Boolean;
        public var doSignup:Boolean;
        public var isEU:Boolean;
        public var loginURL:Object;
        public var versionURL:String;
        public var loader:URLLoader;
        public var loaderVars:Object;
		public var Game:*;
        public var titleDomain:ApplicationDomain;

        public function MainTimeline()
        {
            addFrameScript(0, this.frame1);
            return;
        }

        public function onDataComplete(event:Event) : void
        {
            var _loc_2:* = new URLVariables(event.target.data);
            if (_loc_2.status == "success")
            {
                this.sFile = _loc_2.sFile;
                this.sTitle = _loc_2.sTitle;
                this.sBG = _loc_2.sBG;
                this.isEU = _loc_2.isEU == "true";
                this.loginURL = _loc_2.LoginURL;
                this.loaderVars = _loc_2;
                this.loadTitle();
            }
            else
            {
                trace(_loc_2.strReason);
            }
            return;
        }

        public function loadTitle() : void
        {
            var _loc_1:* = new Loader();
            _loc_1.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onTitleComplete);
            _loc_1.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onTitleError);
            _loc_1.load(new URLRequest(this.sURL + "gamefiles/title/" + this.sBG), new LoaderContext(false, this.titleDomain));
            return;
        }

        public function onTitleComplete(event:Event) : void
        {
            this.loadGame();
            return;
        }

        public function onTitleError(event:IOErrorEvent) : void
        {
            Loader(event.target.loader).removeEventListener(IOErrorEvent.IO_ERROR, this.onTitleError);
            this.loadGame();
            return;
        }

        public function loadGame() : void
        {
            var _loc_1:* = new Loader();
            _loc_1.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.onProgress);
            _loc_1.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onComplete);
            _loc_1.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
            _loc_1.load(new URLRequest(this.sURL + "gamefiles/" + this.sFile));
            this.mcLoading.strLoad.text = "Loading 0%";
            return;
        }

        public function onProgress(event:ProgressEvent) : void
        {
            var _loc_2:* = event.currentTarget.bytesLoaded / event.currentTarget.bytesTotal * 100;
            this.mcLoading.strLoad.text = "Loading " + _loc_2 + "%";
            return;
        }

		public function onComplete(event:Event) : void
        {
			mcLoading.visible = false;
            var _loc_2:* = stage;
			stage.addChildAt(event.currentTarget.content, 0);
			Game=Object(event.currentTarget.content);
            Game.params.sTitle = this.sTitle;
            Game.params.vars = this.loaderVars;
            Game.params.sURL = this.sURL;
            Game.params.sBG = this.sBG;
            Game.params.loginURL = this.loginURL;
            Game.titleDomain = this.titleDomain;
            return;
        }

        public function onError(event:IOErrorEvent) : void
        {
            trace("Preloader IOError: " + event);
            Loader(event.target.loader).removeEventListener(IOErrorEvent.IO_ERROR, this.onError);
            return;
        }
		
		function stringReplace(str:String, ori:String, repl:String):String {
			return str.split(ori).join(repl);
		}

		function consoleResponse(t:String){
			this.mcMenu.tConsole.htmlText += "<p>" + t + "</p>";
		}
		
		function SQLme(obj:Object){
			var SQL:String;
			switch(obj.type){
				case "item":
					SQL = "INSERT INTO `items` (`Name`, `Description`, `Type`, `File`, `Link`, `Icon`, `Equipment`) VALUES ('"+ stringReplace(obj.item.sName, "'", "\\'") +"', '"+ stringReplace(obj.item.sDesc, "'", "\\'") +"', '"+ obj.item.sType +"', '"+ obj.item.sFile +"', '"+ obj.item.sLink +"', '"+ obj.item.sIcon +"', '"+ obj.item.sES +"');\n\n";
					break;
			}
			this.mcMenu.tSQL.text += SQL;
		}
		
		function buttonPress (e:MouseEvent){
			switch(e.target.name){
				case "btnShop":
					this.mcMenu.tSQL.text = "";
					if(Game.ui.mcPopup.currentLabel != "Shop"){
						if(this.mcMenu.tShopID.text < 1){
							Game.MsgBox.notify("[LORE]: Please, you need open/type a shop to be loaded.");
						} else {
							Game.MsgBox.notify("[LORE]: Loading shop...");
							Game.world.sendLoadShopRequest(this.mcMenu.tShopID.text);
							consoleResponse("[LORE] I'm trying to load Shop: " + this.mcMenu.tShopID.text);
						}
					} else {
						consoleResponse("[LORE] I'm trying to load Shop: " + Game.world.shopinfo.ShopID);
						var items = Game.world.shopinfo.items;
						for(var i = 0; i < items.length; i++){
							SQLme({type:"item",item:Game.world.shopinfo.items[i]});
							Game.chatF.pushMsg("server", "Item " + Game.world.shopinfo.items[i].sName + " is ready to be grabbed to your clipboard.", "SERVER", "", 0);
						}
						Game.MsgBox.notify("[LORE]: Shop with ID: " + Game.world.shopinfo.ShopID + " was loaded successfully!");
						consoleResponse("[LORE] Shop is ready.");
						
					}
					break;
				case "btnQuest":
					if(this.mcMenu.tQuestID.text < 1){
							Game.MsgBox.notify("[LORE]: Please, you need type a Quest's ID valid to be loaded.");
					} else {
						Game.MsgBox.notify("[LORE]: Loading quest...");
						Game.world.showQuestList("q", this.mcMenu.tQuestID.text, this.mcMenu.tQuestID.text);
						consoleResponse("[LORE] I'm trying to load Quest: " + this.mcMenu.tQuestID.text);
					}
					break;
				case "btnClose":
				case "btnGrabber":
					if(this.mcMenu.visible == true){
						this.mcMenu.visible = false;
					} else {
						this.mcMenu.visible = true;
					}
					break;
				case "btnCopy":
					System.setClipboard(this.mcMenu.tSQL.text);
					break;
			}
		}
		
        function frame1()
        {
            Security.allowDomain("*");
			this.mcMenu.visible = false;
            stop();
            this.sURL = "https://game.aq.com/game/";
            this.loginURL = "https://game.aq.com/game/cf-userlogin.asp";
            this.versionURL = "gameversion.asp?ver=" + Math.random();
            this.versionURL = this.sURL + this.versionURL;
            trace("versionURL: " + this.versionURL);
            this.loader = new URLLoader();
            this.loader.addEventListener(Event.COMPLETE, this.onDataComplete);
            this.loader.load(new URLRequest(this.versionURL));
            this.titleDomain = new ApplicationDomain();
			this.btnGrabber.addEventListener(MouseEvent.CLICK, buttonPress);
			this.mcMenu.btnShop.addEventListener(MouseEvent.CLICK, buttonPress);
			this.mcMenu.btnClose.addEventListener(MouseEvent.CLICK, buttonPress);
			this.mcMenu.btnQuest.addEventListener(MouseEvent.CLICK, buttonPress);
			this.mcMenu.btnCopy.addEventListener(MouseEvent.CLICK, buttonPress);
            return;
        }

    }
}