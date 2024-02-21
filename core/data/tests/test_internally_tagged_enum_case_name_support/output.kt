@file:NoLiveLiterals

package com.agilebits.onepassword

import androidx.compose.runtime.NoLiveLiterals
import kotlinx.serialization.*

@Serializable
sealed class AdvancedEnum {
	@Serializable
	@SerialName("unitVariant")
	object UnitVariant: AdvancedEnum()
	@Serializable
	@SerialName("A")
	data class AnonymousStruct(val field1: String): AdvancedEnum()
	@Serializable
	@SerialName("otherAnonymousStruct")
	data class OtherAnonymousStruct(val field1: UInt, val field2: Float): AdvancedEnum()
	@Serializable
	@SerialName("B")
	data class Rename(val field3: Boolean?): AdvancedEnum()
}

