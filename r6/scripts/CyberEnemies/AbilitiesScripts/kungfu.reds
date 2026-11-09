// module CyberEnemies.KungFuu

// public class ActivateEffector extends Effector {
//   protected func ActionOn(owner: ref<GameObject>) -> Void {
//     this.ExecuteAction(owner);
//   }

//   protected func RepeatedAction(owner: ref<GameObject>) -> Void {
//     this.ExecuteAction(owner);
//   }

//   private final func ExecuteAction(owner: ref<GameObject>) -> Void {
//     if StatusEffectSystem.ObjectHasStatusEffect(owner, t"BaseStatusEffect.CEKungFuCooldown") {
//         return;
//     }

//     LogChannel(n"DEBUG", "on activate! ");

//     StatusEffectHelper.ApplyStatusEffect(owner, t"CyberEnemies.KungFuEffect");
//     StatusEffectHelper.ApplyStatusEffect(owner, t"BaseStatusEffect.CEKungFuCooldown");   
//   }
// }
