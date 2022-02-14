func void ZS_Unconscious ()
{	

/*
// код пиранй
	PrintDebugNpc		(PD_ZS_FRAME, "ZS_Unconscious" );				
	C_ZSInit();
	Npc_PercEnable  	(self , PERC_ASSESSMAGIC,		B_AssessMagic				);
	Mdl_ApplyRandomAni	( self, "S_WOUNDED","T_WOUNDED_TRY");
	Mdl_ApplyRandomAniFreq	( self, "S_WOUNDED", 8);
	
	self.aivar[AIV_PLUNDERED] = FALSE;
*/

    PrintDebugNpc(PD_ZS_FRAME,"ZS_Unconscious");
    C_ZSInit();
    Npc_PercEnable(self,PERC_ASSESSMAGIC,B_AssessMagic);
    Mdl_ApplyRandomAni(self,"S_WOUNDED","T_WOUNDED_TRY");
    Mdl_ApplyRandomAniFreq(self,"S_WOUNDED",8);
    Mdl_ApplyRandomAni(self,"S_WOUNDEDB","T_WOUNDEDB_TRY");
    Mdl_ApplyRandomAniFreq(self,"S_WOUNDEDB",4);
    self.aivar[AIV_PLUNDERED] = FALSE;

// примечание от пираней	
	//SN 24.09.00: fьr die PublisherDemo auskommentiert, da die Animationen noch nicht toll sind (Absprache mit Alex) -> wenn bessere Animationen da sind, wieder einkommentieren!
	//Mdl_ApplyRandomAni	( self, "S_WOUNDEDB","T_WOUNDEDB_TRY");
	//Mdl_ApplyRandomAniFreq	( self, "S_WOUNDEDB", 8);
	
	if (Npc_CanSeeNpc 	(self, other)  &&  self.guild < GIL_SEPERATOR_ORC )
	{
		PrintDebugNpc	(PD_ZS_CHECK, "...NSC kann Tдter sehen!" );
		if (!Npc_IsPlayer	( self))
		{				
			B_AssessAndMemorize(NEWS_DEFEAT, NEWS_SOURCE_WITNESS, self, other, self);
		};
	};

	C_StopLookAt 		(self);
	AI_StopPointAt 		(self);

	if (C_BodyStateContains(self, BS_SWIM))
	{
		PrintDebugNpc	(PD_ZS_CHECK, "...NSC ertrinkt!" );				
		AI_StartState	(self,	ZS_Dead,	0,	"");
		return;
	};

	//-------- Erfahrungspunkte fьr den Spieler ? --------
	if	Npc_IsPlayer   (other)
	||	(C_NpcIsHuman  (other) && other.aivar[AIV_PARTYMEMBER])
	||	(C_NpcIsMonster(other) && other.aivar[AIV_MM_PARTYMEMBER])
	{
		PrintDebugNpc	(PD_ZS_CHECK, "...von SC oder Partymember besiegt!" );				
		B_UnconciousXP();
		self.aivar[ AIV_WASDEFEATEDBYSC ] = TRUE;
	};

	if ( Npc_IsPlayer	(self ) )
	{
		PrintDebugNpc	(PD_ZS_CHECK, "...SC besiegt!" );				
		other.aivar[ AIV_HASDEFEATEDSC ] = TRUE;
	};
};