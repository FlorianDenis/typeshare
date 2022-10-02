/**
 * Generated by typeshare 1.0.0
 */

@file:NoLiveLiterals

package com.agilebits.onepassword

import androidx.compose.runtime.NoLiveLiterals
import kotlinx.serialization.*

@Serializable
data class GenericStruct<A, B> (
	var field_a: A,
	var field_b: List<B>
)

@Serializable
data class GenericStructUsingGenericStruct<T> (
	var struct_field: GenericStruct<String, T>,
	var second_struct_field: GenericStruct<T, String>,
	var third_struct_field: GenericStruct<T, List<T>>
)

@Serializable
sealed class EnumUsingGenericStruct {
	@Serializable
	@SerialName("VariantA")
	data class VariantA(val content: GenericStruct<String, Float>): EnumUsingGenericStruct()
	@Serializable
	@SerialName("VariantB")
	data class VariantB(val content: GenericStruct<String, Int>): EnumUsingGenericStruct()
	@Serializable
	@SerialName("VariantC")
	data class VariantC(val content: GenericStruct<String, Boolean>): EnumUsingGenericStruct()
	@Serializable
	@SerialName("VariantD")
	data class VariantD(val content: GenericStructUsingGenericStruct<Unit>): EnumUsingGenericStruct()
}
