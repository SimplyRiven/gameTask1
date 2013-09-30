package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.*;
	
	/**
	 * ...
	 * @author SimplyRiven
	 */
	public class Main extends Sprite 
	{
		
		private var tHeroStats:TextField = new TextField;
		private var tEnemyStats:TextField = new TextField;
		private var tRound:TextField = new TextField;
		private var tEnd:TextField = new TextField;
		private var heroHealthPoints:int = 100;
		private var heroAttackDamage:int = 25;
		private var heroDefence:int = 5;
		private var heroDamage:Number;
		private var enemyName:String = "Goblin";
		private var enemyHealthPoints:int = 100;
		private var enemyAttackDamage:int = 20;
		private var enemyDefence:int = 5;
		private var enemyDamage:Number = Math.ceil(Math.random() * 15);
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			tRound.border = true;
			tRound.width = 350;
			tRound.height = 599;
			tRound.wordWrap = true;
			
			//Endgame
			tEnd.x = 550;
			tEnd.width = 200;
			tEnd.border = true;
			tEnd.defaultTextFormat = new TextFormat ("Arial", 50);
			
			// Right-hand statistic box (Hero)
			tHeroStats.border = true;
			tHeroStats.width = 150;
			tHeroStats.height = 200;
			tHeroStats.x = 350;
			
			// Right-hand statistic box (Enemy)
			tEnemyStats.border = true;
			tEnemyStats.width = 150;
			tEnemyStats.height = 100;
			tEnemyStats.x = 350;
			tEnemyStats.y = 100;
			
			//Random damage loop per round (Hero+Enemy)
			
			for (var i:int = 1; i <= 10; i++)
			{
				// ADD defensive value factors
				heroDamage = Math.floor(Math.random() * heroAttackDamage)
				enemyDamage = Math.floor(Math.random() * enemyAttackDamage)
				enemyHealthPoints -= heroDamage;
				heroHealthPoints -= enemyDamage;
				
				if (heroDamage != 0 && enemyDamage != 0)
				{
					tRound.appendText("Round: " + i + "\n" + "You inflicted " + heroDamage + " damage onto the " + enemyName + " and lost " + enemyDamage + " health this round." + "\n\n");
				}
				else if (heroDamage == 0 && enemyDamage == 0)
				{
					tRound.appendText("round: " + i + "\n" + "Both you and the " + enemyName + " missed your attacks, therefore no damage was inflicted in this round." + "\n\n");
				}
				else if (heroDamage == 0)
				{
					tRound.appendText("Round: " + i + "\n" + "Your sword just barely missed the goblin and you inflict 0 damage." + " But lost " + enemyDamage + " health this round." + "\n\n");
				}
				else if (enemyDamage == 0)
				{
					tRound.appendText("Round: " + i + "\n" + "You inflicted " + heroDamage + " damage onto the " + enemyName + "." + " But the Goblin missed, hence, you lost 0 health this round." + "\n\n");
				}
				//On death
				if (heroHealthPoints <= 0 && enemyHealthPoints <= 0)
				{
					heroHealthPoints = 0
					enemyHealthPoints = 0
					tEnd.text = "It's a tie"
					addChild(tEnd);
					break
				}
				else if (heroHealthPoints <= 0)
				{
					heroHealthPoints = 0
					tEnd.text = "You lose"
					addChild(tEnd);
					break
				}
				else if (enemyHealthPoints <= 0)
				{
					enemyHealthPoints = 0
					tEnd.text = "You win!"
					addChild(tEnd);
					break
				}
				else if (enemyHealthPoints >= 1 && heroHealthPoints >= 1)
				{
					tEnd.text = "It's a tie"
					addChild(tEnd);
				}
			}
			
			
			addChild(tHeroStats);
			addChild(tEnemyStats);
			addChild(tRound);
			stage.addEventListener(Event.ENTER_FRAME, gameloop);
		}
		
		private function gameloop(e:Event):void
		{
			tHeroStats.text = "Hero statistics\n\n" + "Health: " + heroHealthPoints + "/100" + "\nAttack: " + heroAttackDamage + "\nDefence: " + heroDefence;
			tEnemyStats.text = enemyName + " statistics\n\n" + "Health: " + enemyHealthPoints + "/100" + "\nAttack: " + enemyAttackDamage + "\nDefence: " + enemyDefence;
		}
		
	}
	
}