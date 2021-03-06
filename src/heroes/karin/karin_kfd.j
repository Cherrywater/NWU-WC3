scope KarinKFD

    globals
        private constant integer BUFF_ID    = 'BK03'    // Buff ID of "Kongou Fuusa (chains)" 
        private constant integer BUFF_ID2   = 'BK05'    // Buff ID of "Kongou Fuusa (aoe sfx)" 
        private constant string EFFECT      = "Abilities\\Spells\\Undead\\DeathandDecay\\DeathandDecayTarget.mdl" 
    endglobals

    private function Conditions takes nothing returns boolean
        return GetUnitAbilityLevel(GetTriggerUnit(), BUFF_ID) > 0 or GetUnitAbilityLevel(GetTriggerUnit(), BUFF_ID2) > 0
    endfunction
    
    private function Actions takes nothing returns nothing
        local unit c = GetTriggerUnit()
        local real x = GetUnitX(c)
        local real y = GetUnitY(c)
        local texttag tt // =CreateTextTag()
        local integer i = 0
        local integer stacks = 0
        
        loop
            exitwhen i > 12
            if IsUnitInGroup(c, KarinChainGroup[i]) then
                set stacks = stacks + 1
                set tt = CreateTextTag()
                call DestroyEffect(AddSpecialEffect (EFFECT, x, y))
                call Damage_Spell(KF_Karin[i],c,25*KF_level[i])
                call SetUnitState(c, UNIT_STATE_MANA, GetUnitState(c, UNIT_STATE_MANA) - 50*KF_level[i])
                
                call SetTextTagText(tt,"-" + I2S(50*KF_level[i]),.024)
                call SetTextTagPos(tt,x-16.,y+stacks*20,.0)
                call SetTextTagColor(tt,82,82,255,255)
                call SetTextTagVelocity(tt,.0,.04)

                call SetTextTagVisibility(tt,false)
            
                if (IsVisibleToPlayer(x, y, GetLocalPlayer()) == true) then
                    call SetTextTagVisibility(tt, true)
                endif
                
                call SetTextTagFadepoint(tt,2.)
                call SetTextTagLifespan(tt,5.)
                call SetTextTagPermanent(tt,false) 
                
                call GroupRemoveUnit(KarinChainGroup[i], c)
                set tt = null
            endif
            set i = i + 1
        endloop

        set tt = null
        set c = null
    endfunction

//===========================================================================

    public function Init takes nothing returns nothing
        local trigger t = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(t,EVENT_PLAYER_UNIT_SPELL_CAST)
        call TriggerAddCondition(t, Condition(function Conditions))
        call TriggerAddAction(t, function Actions)
        set t = null
        debug Test_Success(SCOPE_PREFIX + " loaded")
    endfunction

endscope