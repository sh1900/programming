       ЃK"	   щ^жAbrain.Event:2X/Ќf       Kp	mщ^жA"ѓЇ
h
placeholders/sampled_usersPlaceholder*
dtype0*
shape: *#
_output_shapes
:џџџџџџџџџ
l
placeholders/sampled_pos_itemsPlaceholder*
dtype0*
shape: *#
_output_shapes
:џџџџџџџџџ
l
placeholders/sampled_neg_itemsPlaceholder*
dtype0*
shape: *#
_output_shapes
:џџџџџџџџџ
q
 variables/truncated_normal/shapeConst*
valueB"  
   *
dtype0*
_output_shapes
:
d
variables/truncated_normal/meanConst*
valueB
 *    *
dtype0*
_output_shapes
: 
f
!variables/truncated_normal/stddevConst*
valueB
 *шЁ>*
dtype0*
_output_shapes
: 
Г
*variables/truncated_normal/TruncatedNormalTruncatedNormal variables/truncated_normal/shape*
seed2в	*
T0*
seedБџх)*
dtype0*
_output_shapes
:	


variables/truncated_normal/mulMul*variables/truncated_normal/TruncatedNormal!variables/truncated_normal/stddev*
T0*
_output_shapes
:	


variables/truncated_normalAddvariables/truncated_normal/mulvariables/truncated_normal/mean*
T0*
_output_shapes
:	

s
"variables/truncated_normal_1/shapeConst*
valueB"m  
   *
dtype0*
_output_shapes
:
f
!variables/truncated_normal_1/meanConst*
valueB
 *    *
dtype0*
_output_shapes
: 
h
#variables/truncated_normal_1/stddevConst*
valueB
 *шЁ>*
dtype0*
_output_shapes
: 
З
,variables/truncated_normal_1/TruncatedNormalTruncatedNormal"variables/truncated_normal_1/shape*
seed2в	*
T0*
seedБџх)*
dtype0*
_output_shapes
:	э

Є
 variables/truncated_normal_1/mulMul,variables/truncated_normal_1/TruncatedNormal#variables/truncated_normal_1/stddev*
T0*
_output_shapes
:	э


variables/truncated_normal_1Add variables/truncated_normal_1/mul!variables/truncated_normal_1/mean*
T0*
_output_shapes
:	э


variables/user_factors
VariableV2*
	container *
dtype0*
shared_name *
shape:	
*
_output_shapes
:	

й
variables/user_factors/AssignAssignvariables/user_factorsvariables/truncated_normal*
use_locking(*)
_class
loc:@variables/user_factors*
T0*
validate_shape(*
_output_shapes
:	


variables/user_factors/readIdentityvariables/user_factors*)
_class
loc:@variables/user_factors*
T0*
_output_shapes
:	


variables/item_factors
VariableV2*
	container *
dtype0*
shared_name *
shape:	э
*
_output_shapes
:	э

л
variables/item_factors/AssignAssignvariables/item_factorsvariables/truncated_normal_1*
use_locking(*)
_class
loc:@variables/item_factors*
T0*
validate_shape(*
_output_shapes
:	э


variables/item_factors/readIdentityvariables/item_factors*)
_class
loc:@variables/item_factors*
T0*
_output_shapes
:	э

^
variables/zerosConst*
valueBэ*    *
dtype0*
_output_shapes	
:э

variables/item_bias
VariableV2*
	container *
dtype0*
shared_name *
shape:э*
_output_shapes	
:э
С
variables/item_bias/AssignAssignvariables/item_biasvariables/zeros*
use_locking(*&
_class
loc:@variables/item_bias*
T0*
validate_shape(*
_output_shapes	
:э

variables/item_bias/readIdentityvariables/item_bias*&
_class
loc:@variables/item_bias*
T0*
_output_shapes	
:э
­

loss/usersGathervariables/user_factors/readplaceholders/sampled_users*
Tindices0*
validate_indices(*
Tparams0*'
_output_shapes
:џџџџџџџџџ

Е
loss/pos_itemsGathervariables/item_factors/readplaceholders/sampled_pos_items*
Tindices0*
validate_indices(*
Tparams0*'
_output_shapes
:џџџџџџџџџ

Е
loss/neg_itemsGathervariables/item_factors/readplaceholders/sampled_neg_items*
Tindices0*
validate_indices(*
Tparams0*'
_output_shapes
:џџџџџџџџџ

В
loss/pos_item_biasGathervariables/item_bias/readplaceholders/sampled_pos_items*
Tindices0*
validate_indices(*
Tparams0*#
_output_shapes
:џџџџџџџџџ
В
loss/neg_item_biasGathervariables/item_bias/readplaceholders/sampled_neg_items*
Tindices0*
validate_indices(*
Tparams0*#
_output_shapes
:џџџџџџџџџ
a
loss/subSubloss/pos_itemsloss/neg_items*
T0*'
_output_shapes
:џџџџџџџџџ

W
loss/mulMul
loss/usersloss/sub*
T0*'
_output_shapes
:џџџџџџџџџ

\
loss/Sum/reduction_indicesConst*
value	B :*
dtype0*
_output_shapes
: 

loss/SumSumloss/mulloss/Sum/reduction_indices*
	keep_dims( *

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
g

loss/sub_1Subloss/pos_item_biasloss/neg_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
S
loss/addAdd
loss/sub_1loss/Sum*
T0*#
_output_shapes
:џџџџџџџџџ
G
loss/NegNegloss/add*
T0*#
_output_shapes
:џџџџџџџџџ
G
loss/ExpExploss/Neg*
T0*#
_output_shapes
:џџџџџџџџџ
Q
loss/add_1/xConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
W

loss/add_1Addloss/add_1/xloss/Exp*
T0*#
_output_shapes
:џџџџџџџџџ
I
loss/LogLog
loss/add_1*
T0*#
_output_shapes
:џџџџџџџџџ
I

loss/Neg_1Negloss/Log*
T0*#
_output_shapes
:џџџџџџџџџ
T

loss/ConstConst*
valueB: *
dtype0*
_output_shapes
:
g

loss/Sum_1Sum
loss/Neg_1
loss/Const*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
O

loss/pow/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
Y
loss/powPow
loss/users
loss/pow/y*
T0*'
_output_shapes
:џџџџџџџџџ

]
loss/Const_1Const*
valueB"       *
dtype0*
_output_shapes
:
g

loss/Sum_2Sumloss/powloss/Const_1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
Q
loss/mul_1/xConst*
valueB
 *
з#<*
dtype0*
_output_shapes
: 
L

loss/mul_1Mulloss/mul_1/x
loss/Sum_2*
T0*
_output_shapes
: 
Q
loss/pow_1/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
a

loss/pow_1Powloss/pos_itemsloss/pow_1/y*
T0*'
_output_shapes
:џџџџџџџџџ

]
loss/Const_2Const*
valueB"       *
dtype0*
_output_shapes
:
i

loss/Sum_3Sum
loss/pow_1loss/Const_2*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
Q
loss/mul_2/xConst*
valueB
 *
з#<*
dtype0*
_output_shapes
: 
L

loss/mul_2Mulloss/mul_2/x
loss/Sum_3*
T0*
_output_shapes
: 
Q
loss/pow_2/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
a

loss/pow_2Powloss/pos_item_biasloss/pow_2/y*
T0*#
_output_shapes
:џџџџџџџџџ
V
loss/Const_3Const*
valueB: *
dtype0*
_output_shapes
:
i

loss/Sum_4Sum
loss/pow_2loss/Const_3*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
J

loss/add_2Add
loss/mul_2
loss/Sum_4*
T0*
_output_shapes
: 
Q
loss/pow_3/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
a

loss/pow_3Powloss/neg_itemsloss/pow_3/y*
T0*'
_output_shapes
:џџџџџџџџџ

]
loss/Const_4Const*
valueB"       *
dtype0*
_output_shapes
:
i

loss/Sum_5Sum
loss/pow_3loss/Const_4*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
Q
loss/mul_3/xConst*
valueB
 *
з#<*
dtype0*
_output_shapes
: 
L

loss/mul_3Mulloss/mul_3/x
loss/Sum_5*
T0*
_output_shapes
: 
Q
loss/pow_4/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
a

loss/pow_4Powloss/neg_item_biasloss/pow_4/y*
T0*#
_output_shapes
:џџџџџџџџџ
V
loss/Const_5Const*
valueB: *
dtype0*
_output_shapes
:
i

loss/Sum_6Sum
loss/pow_4loss/Const_5*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
J

loss/add_3Add
loss/mul_3
loss/Sum_6*
T0*
_output_shapes
: 
J

loss/add_4Add
loss/mul_1
loss/add_2*
T0*
_output_shapes
: 
J

loss/add_5Add
loss/add_4
loss/add_3*
T0*
_output_shapes
: 
J

loss/sub_2Sub
loss/add_5
loss/Sum_1*
T0*
_output_shapes
: 
R
gradients/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
T
gradients/ConstConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
Y
gradients/FillFillgradients/Shapegradients/Const*
T0*
_output_shapes
: 
b
gradients/loss/sub_2_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/sub_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_2_grad/Shape!gradients/loss/sub_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ѕ
gradients/loss/sub_2_grad/SumSumgradients/Fill/gradients/loss/sub_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/sub_2_grad/ReshapeReshapegradients/loss/sub_2_grad/Sumgradients/loss/sub_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Љ
gradients/loss/sub_2_grad/Sum_1Sumgradients/Fill1gradients/loss/sub_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
h
gradients/loss/sub_2_grad/NegNeggradients/loss/sub_2_grad/Sum_1*
T0*
_output_shapes
:

#gradients/loss/sub_2_grad/Reshape_1Reshapegradients/loss/sub_2_grad/Neg!gradients/loss/sub_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/sub_2_grad/tuple/group_depsNoOp"^gradients/loss/sub_2_grad/Reshape$^gradients/loss/sub_2_grad/Reshape_1
х
2gradients/loss/sub_2_grad/tuple/control_dependencyIdentity!gradients/loss/sub_2_grad/Reshape+^gradients/loss/sub_2_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/sub_2_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/sub_2_grad/tuple/control_dependency_1Identity#gradients/loss/sub_2_grad/Reshape_1+^gradients/loss/sub_2_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/sub_2_grad/Reshape_1*
T0*
_output_shapes
: 
b
gradients/loss/add_5_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/add_5_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/add_5_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_5_grad/Shape!gradients/loss/add_5_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Щ
gradients/loss/add_5_grad/SumSum2gradients/loss/sub_2_grad/tuple/control_dependency/gradients/loss/add_5_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/add_5_grad/ReshapeReshapegradients/loss/add_5_grad/Sumgradients/loss/add_5_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Э
gradients/loss/add_5_grad/Sum_1Sum2gradients/loss/sub_2_grad/tuple/control_dependency1gradients/loss/add_5_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/add_5_grad/Reshape_1Reshapegradients/loss/add_5_grad/Sum_1!gradients/loss/add_5_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_5_grad/tuple/group_depsNoOp"^gradients/loss/add_5_grad/Reshape$^gradients/loss/add_5_grad/Reshape_1
х
2gradients/loss/add_5_grad/tuple/control_dependencyIdentity!gradients/loss/add_5_grad/Reshape+^gradients/loss/add_5_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_5_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/add_5_grad/tuple/control_dependency_1Identity#gradients/loss/add_5_grad/Reshape_1+^gradients/loss/add_5_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/add_5_grad/Reshape_1*
T0*
_output_shapes
: 
q
'gradients/loss/Sum_1_grad/Reshape/shapeConst*
valueB:*
dtype0*
_output_shapes
:
О
!gradients/loss/Sum_1_grad/ReshapeReshape4gradients/loss/sub_2_grad/tuple/control_dependency_1'gradients/loss/Sum_1_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
i
gradients/loss/Sum_1_grad/ShapeShape
loss/Neg_1*
T0*
out_type0*
_output_shapes
:
Њ
gradients/loss/Sum_1_grad/TileTile!gradients/loss/Sum_1_grad/Reshapegradients/loss/Sum_1_grad/Shape*
T0*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ
b
gradients/loss/add_4_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/add_4_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/add_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_4_grad/Shape!gradients/loss/add_4_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Щ
gradients/loss/add_4_grad/SumSum2gradients/loss/add_5_grad/tuple/control_dependency/gradients/loss/add_4_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/add_4_grad/ReshapeReshapegradients/loss/add_4_grad/Sumgradients/loss/add_4_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Э
gradients/loss/add_4_grad/Sum_1Sum2gradients/loss/add_5_grad/tuple/control_dependency1gradients/loss/add_4_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/add_4_grad/Reshape_1Reshapegradients/loss/add_4_grad/Sum_1!gradients/loss/add_4_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_4_grad/tuple/group_depsNoOp"^gradients/loss/add_4_grad/Reshape$^gradients/loss/add_4_grad/Reshape_1
х
2gradients/loss/add_4_grad/tuple/control_dependencyIdentity!gradients/loss/add_4_grad/Reshape+^gradients/loss/add_4_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_4_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/add_4_grad/tuple/control_dependency_1Identity#gradients/loss/add_4_grad/Reshape_1+^gradients/loss/add_4_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/add_4_grad/Reshape_1*
T0*
_output_shapes
: 
b
gradients/loss/add_3_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/add_3_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/add_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_3_grad/Shape!gradients/loss/add_3_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ы
gradients/loss/add_3_grad/SumSum4gradients/loss/add_5_grad/tuple/control_dependency_1/gradients/loss/add_3_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/add_3_grad/ReshapeReshapegradients/loss/add_3_grad/Sumgradients/loss/add_3_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Я
gradients/loss/add_3_grad/Sum_1Sum4gradients/loss/add_5_grad/tuple/control_dependency_11gradients/loss/add_3_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/add_3_grad/Reshape_1Reshapegradients/loss/add_3_grad/Sum_1!gradients/loss/add_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_3_grad/tuple/group_depsNoOp"^gradients/loss/add_3_grad/Reshape$^gradients/loss/add_3_grad/Reshape_1
х
2gradients/loss/add_3_grad/tuple/control_dependencyIdentity!gradients/loss/add_3_grad/Reshape+^gradients/loss/add_3_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_3_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/add_3_grad/tuple/control_dependency_1Identity#gradients/loss/add_3_grad/Reshape_1+^gradients/loss/add_3_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/add_3_grad/Reshape_1*
T0*
_output_shapes
: 
r
gradients/loss/Neg_1_grad/NegNeggradients/loss/Sum_1_grad/Tile*
T0*#
_output_shapes
:џџџџџџџџџ
b
gradients/loss/mul_1_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/mul_1_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_1_grad/Shape!gradients/loss/mul_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/mul_1_grad/mulMul2gradients/loss/add_4_grad/tuple/control_dependency
loss/Sum_2*
T0*
_output_shapes
: 
Д
gradients/loss/mul_1_grad/SumSumgradients/loss/mul_1_grad/mul/gradients/loss/mul_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/mul_1_grad/ReshapeReshapegradients/loss/mul_1_grad/Sumgradients/loss/mul_1_grad/Shape*
T0*
Tshape0*
_output_shapes
: 

gradients/loss/mul_1_grad/mul_1Mulloss/mul_1/x2gradients/loss/add_4_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_1_grad/Sum_1Sumgradients/loss/mul_1_grad/mul_11gradients/loss/mul_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/mul_1_grad/Reshape_1Reshapegradients/loss/mul_1_grad/Sum_1!gradients/loss/mul_1_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/mul_1_grad/tuple/group_depsNoOp"^gradients/loss/mul_1_grad/Reshape$^gradients/loss/mul_1_grad/Reshape_1
х
2gradients/loss/mul_1_grad/tuple/control_dependencyIdentity!gradients/loss/mul_1_grad/Reshape+^gradients/loss/mul_1_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/mul_1_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/mul_1_grad/tuple/control_dependency_1Identity#gradients/loss/mul_1_grad/Reshape_1+^gradients/loss/mul_1_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/mul_1_grad/Reshape_1*
T0*
_output_shapes
: 
b
gradients/loss/add_2_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/add_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/add_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_2_grad/Shape!gradients/loss/add_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ы
gradients/loss/add_2_grad/SumSum4gradients/loss/add_4_grad/tuple/control_dependency_1/gradients/loss/add_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/add_2_grad/ReshapeReshapegradients/loss/add_2_grad/Sumgradients/loss/add_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Я
gradients/loss/add_2_grad/Sum_1Sum4gradients/loss/add_4_grad/tuple/control_dependency_11gradients/loss/add_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/add_2_grad/Reshape_1Reshapegradients/loss/add_2_grad/Sum_1!gradients/loss/add_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_2_grad/tuple/group_depsNoOp"^gradients/loss/add_2_grad/Reshape$^gradients/loss/add_2_grad/Reshape_1
х
2gradients/loss/add_2_grad/tuple/control_dependencyIdentity!gradients/loss/add_2_grad/Reshape+^gradients/loss/add_2_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_2_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/add_2_grad/tuple/control_dependency_1Identity#gradients/loss/add_2_grad/Reshape_1+^gradients/loss/add_2_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/add_2_grad/Reshape_1*
T0*
_output_shapes
: 
b
gradients/loss/mul_3_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/mul_3_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_3_grad/Shape!gradients/loss/mul_3_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/mul_3_grad/mulMul2gradients/loss/add_3_grad/tuple/control_dependency
loss/Sum_5*
T0*
_output_shapes
: 
Д
gradients/loss/mul_3_grad/SumSumgradients/loss/mul_3_grad/mul/gradients/loss/mul_3_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/mul_3_grad/ReshapeReshapegradients/loss/mul_3_grad/Sumgradients/loss/mul_3_grad/Shape*
T0*
Tshape0*
_output_shapes
: 

gradients/loss/mul_3_grad/mul_1Mulloss/mul_3/x2gradients/loss/add_3_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_3_grad/Sum_1Sumgradients/loss/mul_3_grad/mul_11gradients/loss/mul_3_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/mul_3_grad/Reshape_1Reshapegradients/loss/mul_3_grad/Sum_1!gradients/loss/mul_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/mul_3_grad/tuple/group_depsNoOp"^gradients/loss/mul_3_grad/Reshape$^gradients/loss/mul_3_grad/Reshape_1
х
2gradients/loss/mul_3_grad/tuple/control_dependencyIdentity!gradients/loss/mul_3_grad/Reshape+^gradients/loss/mul_3_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/mul_3_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/mul_3_grad/tuple/control_dependency_1Identity#gradients/loss/mul_3_grad/Reshape_1+^gradients/loss/mul_3_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/mul_3_grad/Reshape_1*
T0*
_output_shapes
: 
q
'gradients/loss/Sum_6_grad/Reshape/shapeConst*
valueB:*
dtype0*
_output_shapes
:
О
!gradients/loss/Sum_6_grad/ReshapeReshape4gradients/loss/add_3_grad/tuple/control_dependency_1'gradients/loss/Sum_6_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
i
gradients/loss/Sum_6_grad/ShapeShape
loss/pow_4*
T0*
out_type0*
_output_shapes
:
Њ
gradients/loss/Sum_6_grad/TileTile!gradients/loss/Sum_6_grad/Reshapegradients/loss/Sum_6_grad/Shape*
T0*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ

"gradients/loss/Log_grad/Reciprocal
Reciprocal
loss/add_1^gradients/loss/Neg_1_grad/Neg*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/Log_grad/mulMulgradients/loss/Neg_1_grad/Neg"gradients/loss/Log_grad/Reciprocal*
T0*#
_output_shapes
:џџџџџџџџџ
x
'gradients/loss/Sum_2_grad/Reshape/shapeConst*
valueB"      *
dtype0*
_output_shapes
:
Т
!gradients/loss/Sum_2_grad/ReshapeReshape4gradients/loss/mul_1_grad/tuple/control_dependency_1'gradients/loss/Sum_2_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
g
gradients/loss/Sum_2_grad/ShapeShapeloss/pow*
T0*
out_type0*
_output_shapes
:
Ў
gradients/loss/Sum_2_grad/TileTile!gradients/loss/Sum_2_grad/Reshapegradients/loss/Sum_2_grad/Shape*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

b
gradients/loss/mul_2_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/mul_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_2_grad/Shape!gradients/loss/mul_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/mul_2_grad/mulMul2gradients/loss/add_2_grad/tuple/control_dependency
loss/Sum_3*
T0*
_output_shapes
: 
Д
gradients/loss/mul_2_grad/SumSumgradients/loss/mul_2_grad/mul/gradients/loss/mul_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/mul_2_grad/ReshapeReshapegradients/loss/mul_2_grad/Sumgradients/loss/mul_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 

gradients/loss/mul_2_grad/mul_1Mulloss/mul_2/x2gradients/loss/add_2_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_2_grad/Sum_1Sumgradients/loss/mul_2_grad/mul_11gradients/loss/mul_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/mul_2_grad/Reshape_1Reshapegradients/loss/mul_2_grad/Sum_1!gradients/loss/mul_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/mul_2_grad/tuple/group_depsNoOp"^gradients/loss/mul_2_grad/Reshape$^gradients/loss/mul_2_grad/Reshape_1
х
2gradients/loss/mul_2_grad/tuple/control_dependencyIdentity!gradients/loss/mul_2_grad/Reshape+^gradients/loss/mul_2_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/mul_2_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/mul_2_grad/tuple/control_dependency_1Identity#gradients/loss/mul_2_grad/Reshape_1+^gradients/loss/mul_2_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/mul_2_grad/Reshape_1*
T0*
_output_shapes
: 
q
'gradients/loss/Sum_4_grad/Reshape/shapeConst*
valueB:*
dtype0*
_output_shapes
:
О
!gradients/loss/Sum_4_grad/ReshapeReshape4gradients/loss/add_2_grad/tuple/control_dependency_1'gradients/loss/Sum_4_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
i
gradients/loss/Sum_4_grad/ShapeShape
loss/pow_2*
T0*
out_type0*
_output_shapes
:
Њ
gradients/loss/Sum_4_grad/TileTile!gradients/loss/Sum_4_grad/Reshapegradients/loss/Sum_4_grad/Shape*
T0*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ
x
'gradients/loss/Sum_5_grad/Reshape/shapeConst*
valueB"      *
dtype0*
_output_shapes
:
Т
!gradients/loss/Sum_5_grad/ReshapeReshape4gradients/loss/mul_3_grad/tuple/control_dependency_1'gradients/loss/Sum_5_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
i
gradients/loss/Sum_5_grad/ShapeShape
loss/pow_3*
T0*
out_type0*
_output_shapes
:
Ў
gradients/loss/Sum_5_grad/TileTile!gradients/loss/Sum_5_grad/Reshapegradients/loss/Sum_5_grad/Shape*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

q
gradients/loss/pow_4_grad/ShapeShapeloss/neg_item_bias*
T0*
out_type0*
_output_shapes
:
d
!gradients/loss/pow_4_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_4_grad/Shape!gradients/loss/pow_4_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/pow_4_grad/mulMulgradients/loss/Sum_6_grad/Tileloss/pow_4/y*
T0*#
_output_shapes
:џџџџџџџџџ
d
gradients/loss/pow_4_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
t
gradients/loss/pow_4_grad/subSubloss/pow_4/ygradients/loss/pow_4_grad/sub/y*
T0*
_output_shapes
: 

gradients/loss/pow_4_grad/PowPowloss/neg_item_biasgradients/loss/pow_4_grad/sub*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_4_grad/mul_1Mulgradients/loss/pow_4_grad/mulgradients/loss/pow_4_grad/Pow*
T0*#
_output_shapes
:џџџџџџџџџ
Ж
gradients/loss/pow_4_grad/SumSumgradients/loss/pow_4_grad/mul_1/gradients/loss/pow_4_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ј
!gradients/loss/pow_4_grad/ReshapeReshapegradients/loss/pow_4_grad/Sumgradients/loss/pow_4_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
h
#gradients/loss/pow_4_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

!gradients/loss/pow_4_grad/GreaterGreaterloss/neg_item_bias#gradients/loss/pow_4_grad/Greater/y*
T0*#
_output_shapes
:џџџџџџџџџ
f
gradients/loss/pow_4_grad/LogLogloss/neg_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
s
$gradients/loss/pow_4_grad/zeros_like	ZerosLikeloss/neg_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
Р
 gradients/loss/pow_4_grad/SelectSelect!gradients/loss/pow_4_grad/Greatergradients/loss/pow_4_grad/Log$gradients/loss/pow_4_grad/zeros_like*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_4_grad/mul_2Mulgradients/loss/Sum_6_grad/Tile
loss/pow_4*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_4_grad/mul_3Mulgradients/loss/pow_4_grad/mul_2 gradients/loss/pow_4_grad/Select*
T0*#
_output_shapes
:џџџџџџџџџ
К
gradients/loss/pow_4_grad/Sum_1Sumgradients/loss/pow_4_grad/mul_31gradients/loss/pow_4_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/pow_4_grad/Reshape_1Reshapegradients/loss/pow_4_grad/Sum_1!gradients/loss/pow_4_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_4_grad/tuple/group_depsNoOp"^gradients/loss/pow_4_grad/Reshape$^gradients/loss/pow_4_grad/Reshape_1
ђ
2gradients/loss/pow_4_grad/tuple/control_dependencyIdentity!gradients/loss/pow_4_grad/Reshape+^gradients/loss/pow_4_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
ы
4gradients/loss/pow_4_grad/tuple/control_dependency_1Identity#gradients/loss/pow_4_grad/Reshape_1+^gradients/loss/pow_4_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/pow_4_grad/Reshape_1*
T0*
_output_shapes
: 
b
gradients/loss/add_1_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
i
!gradients/loss/add_1_grad/Shape_1Shapeloss/Exp*
T0*
out_type0*
_output_shapes
:
Щ
/gradients/loss/add_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_1_grad/Shape!gradients/loss/add_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
В
gradients/loss/add_1_grad/SumSumgradients/loss/Log_grad/mul/gradients/loss/add_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/add_1_grad/ReshapeReshapegradients/loss/add_1_grad/Sumgradients/loss/add_1_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Ж
gradients/loss/add_1_grad/Sum_1Sumgradients/loss/Log_grad/mul1gradients/loss/add_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ў
#gradients/loss/add_1_grad/Reshape_1Reshapegradients/loss/add_1_grad/Sum_1!gradients/loss/add_1_grad/Shape_1*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
|
*gradients/loss/add_1_grad/tuple/group_depsNoOp"^gradients/loss/add_1_grad/Reshape$^gradients/loss/add_1_grad/Reshape_1
х
2gradients/loss/add_1_grad/tuple/control_dependencyIdentity!gradients/loss/add_1_grad/Reshape+^gradients/loss/add_1_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_1_grad/Reshape*
T0*
_output_shapes
: 
ј
4gradients/loss/add_1_grad/tuple/control_dependency_1Identity#gradients/loss/add_1_grad/Reshape_1+^gradients/loss/add_1_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/add_1_grad/Reshape_1*
T0*#
_output_shapes
:џџџџџџџџџ
g
gradients/loss/pow_grad/ShapeShape
loss/users*
T0*
out_type0*
_output_shapes
:
b
gradients/loss/pow_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
У
-gradients/loss/pow_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_grad/Shapegradients/loss/pow_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/pow_grad/mulMulgradients/loss/Sum_2_grad/Tile
loss/pow/y*
T0*'
_output_shapes
:џџџџџџџџџ

b
gradients/loss/pow_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
n
gradients/loss/pow_grad/subSub
loss/pow/ygradients/loss/pow_grad/sub/y*
T0*
_output_shapes
: 
}
gradients/loss/pow_grad/PowPow
loss/usersgradients/loss/pow_grad/sub*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_grad/mul_1Mulgradients/loss/pow_grad/mulgradients/loss/pow_grad/Pow*
T0*'
_output_shapes
:џџџџџџџџџ

А
gradients/loss/pow_grad/SumSumgradients/loss/pow_grad/mul_1-gradients/loss/pow_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
І
gradients/loss/pow_grad/ReshapeReshapegradients/loss/pow_grad/Sumgradients/loss/pow_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

f
!gradients/loss/pow_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

gradients/loss/pow_grad/GreaterGreater
loss/users!gradients/loss/pow_grad/Greater/y*
T0*'
_output_shapes
:џџџџџџџџџ

`
gradients/loss/pow_grad/LogLog
loss/users*
T0*'
_output_shapes
:џџџџџџџџџ

m
"gradients/loss/pow_grad/zeros_like	ZerosLike
loss/users*
T0*'
_output_shapes
:џџџџџџџџџ

М
gradients/loss/pow_grad/SelectSelectgradients/loss/pow_grad/Greatergradients/loss/pow_grad/Log"gradients/loss/pow_grad/zeros_like*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_grad/mul_2Mulgradients/loss/Sum_2_grad/Tileloss/pow*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_grad/mul_3Mulgradients/loss/pow_grad/mul_2gradients/loss/pow_grad/Select*
T0*'
_output_shapes
:џџџџџџџџџ

Д
gradients/loss/pow_grad/Sum_1Sumgradients/loss/pow_grad/mul_3/gradients/loss/pow_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/pow_grad/Reshape_1Reshapegradients/loss/pow_grad/Sum_1gradients/loss/pow_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
v
(gradients/loss/pow_grad/tuple/group_depsNoOp ^gradients/loss/pow_grad/Reshape"^gradients/loss/pow_grad/Reshape_1
ю
0gradients/loss/pow_grad/tuple/control_dependencyIdentitygradients/loss/pow_grad/Reshape)^gradients/loss/pow_grad/tuple/group_deps*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

у
2gradients/loss/pow_grad/tuple/control_dependency_1Identity!gradients/loss/pow_grad/Reshape_1)^gradients/loss/pow_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/pow_grad/Reshape_1*
T0*
_output_shapes
: 
x
'gradients/loss/Sum_3_grad/Reshape/shapeConst*
valueB"      *
dtype0*
_output_shapes
:
Т
!gradients/loss/Sum_3_grad/ReshapeReshape4gradients/loss/mul_2_grad/tuple/control_dependency_1'gradients/loss/Sum_3_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
i
gradients/loss/Sum_3_grad/ShapeShape
loss/pow_1*
T0*
out_type0*
_output_shapes
:
Ў
gradients/loss/Sum_3_grad/TileTile!gradients/loss/Sum_3_grad/Reshapegradients/loss/Sum_3_grad/Shape*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

q
gradients/loss/pow_2_grad/ShapeShapeloss/pos_item_bias*
T0*
out_type0*
_output_shapes
:
d
!gradients/loss/pow_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_2_grad/Shape!gradients/loss/pow_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/pow_2_grad/mulMulgradients/loss/Sum_4_grad/Tileloss/pow_2/y*
T0*#
_output_shapes
:џџџџџџџџџ
d
gradients/loss/pow_2_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
t
gradients/loss/pow_2_grad/subSubloss/pow_2/ygradients/loss/pow_2_grad/sub/y*
T0*
_output_shapes
: 

gradients/loss/pow_2_grad/PowPowloss/pos_item_biasgradients/loss/pow_2_grad/sub*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_2_grad/mul_1Mulgradients/loss/pow_2_grad/mulgradients/loss/pow_2_grad/Pow*
T0*#
_output_shapes
:џџџџџџџџџ
Ж
gradients/loss/pow_2_grad/SumSumgradients/loss/pow_2_grad/mul_1/gradients/loss/pow_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ј
!gradients/loss/pow_2_grad/ReshapeReshapegradients/loss/pow_2_grad/Sumgradients/loss/pow_2_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
h
#gradients/loss/pow_2_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

!gradients/loss/pow_2_grad/GreaterGreaterloss/pos_item_bias#gradients/loss/pow_2_grad/Greater/y*
T0*#
_output_shapes
:џџџџџџџџџ
f
gradients/loss/pow_2_grad/LogLogloss/pos_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
s
$gradients/loss/pow_2_grad/zeros_like	ZerosLikeloss/pos_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
Р
 gradients/loss/pow_2_grad/SelectSelect!gradients/loss/pow_2_grad/Greatergradients/loss/pow_2_grad/Log$gradients/loss/pow_2_grad/zeros_like*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_2_grad/mul_2Mulgradients/loss/Sum_4_grad/Tile
loss/pow_2*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_2_grad/mul_3Mulgradients/loss/pow_2_grad/mul_2 gradients/loss/pow_2_grad/Select*
T0*#
_output_shapes
:џџџџџџџџџ
К
gradients/loss/pow_2_grad/Sum_1Sumgradients/loss/pow_2_grad/mul_31gradients/loss/pow_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/pow_2_grad/Reshape_1Reshapegradients/loss/pow_2_grad/Sum_1!gradients/loss/pow_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_2_grad/tuple/group_depsNoOp"^gradients/loss/pow_2_grad/Reshape$^gradients/loss/pow_2_grad/Reshape_1
ђ
2gradients/loss/pow_2_grad/tuple/control_dependencyIdentity!gradients/loss/pow_2_grad/Reshape+^gradients/loss/pow_2_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
ы
4gradients/loss/pow_2_grad/tuple/control_dependency_1Identity#gradients/loss/pow_2_grad/Reshape_1+^gradients/loss/pow_2_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/pow_2_grad/Reshape_1*
T0*
_output_shapes
: 
m
gradients/loss/pow_3_grad/ShapeShapeloss/neg_items*
T0*
out_type0*
_output_shapes
:
d
!gradients/loss/pow_3_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_3_grad/Shape!gradients/loss/pow_3_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/pow_3_grad/mulMulgradients/loss/Sum_5_grad/Tileloss/pow_3/y*
T0*'
_output_shapes
:џџџџџџџџџ

d
gradients/loss/pow_3_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
t
gradients/loss/pow_3_grad/subSubloss/pow_3/ygradients/loss/pow_3_grad/sub/y*
T0*
_output_shapes
: 

gradients/loss/pow_3_grad/PowPowloss/neg_itemsgradients/loss/pow_3_grad/sub*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_3_grad/mul_1Mulgradients/loss/pow_3_grad/mulgradients/loss/pow_3_grad/Pow*
T0*'
_output_shapes
:џџџџџџџџџ

Ж
gradients/loss/pow_3_grad/SumSumgradients/loss/pow_3_grad/mul_1/gradients/loss/pow_3_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ќ
!gradients/loss/pow_3_grad/ReshapeReshapegradients/loss/pow_3_grad/Sumgradients/loss/pow_3_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

h
#gradients/loss/pow_3_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

!gradients/loss/pow_3_grad/GreaterGreaterloss/neg_items#gradients/loss/pow_3_grad/Greater/y*
T0*'
_output_shapes
:џџџџџџџџџ

f
gradients/loss/pow_3_grad/LogLogloss/neg_items*
T0*'
_output_shapes
:џџџџџџџџџ

s
$gradients/loss/pow_3_grad/zeros_like	ZerosLikeloss/neg_items*
T0*'
_output_shapes
:џџџџџџџџџ

Ф
 gradients/loss/pow_3_grad/SelectSelect!gradients/loss/pow_3_grad/Greatergradients/loss/pow_3_grad/Log$gradients/loss/pow_3_grad/zeros_like*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_3_grad/mul_2Mulgradients/loss/Sum_5_grad/Tile
loss/pow_3*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_3_grad/mul_3Mulgradients/loss/pow_3_grad/mul_2 gradients/loss/pow_3_grad/Select*
T0*'
_output_shapes
:џџџџџџџџџ

К
gradients/loss/pow_3_grad/Sum_1Sumgradients/loss/pow_3_grad/mul_31gradients/loss/pow_3_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/pow_3_grad/Reshape_1Reshapegradients/loss/pow_3_grad/Sum_1!gradients/loss/pow_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_3_grad/tuple/group_depsNoOp"^gradients/loss/pow_3_grad/Reshape$^gradients/loss/pow_3_grad/Reshape_1
і
2gradients/loss/pow_3_grad/tuple/control_dependencyIdentity!gradients/loss/pow_3_grad/Reshape+^gradients/loss/pow_3_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

ы
4gradients/loss/pow_3_grad/tuple/control_dependency_1Identity#gradients/loss/pow_3_grad/Reshape_1+^gradients/loss/pow_3_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/pow_3_grad/Reshape_1*
T0*
_output_shapes
: 

gradients/loss/Exp_grad/mulMul4gradients/loss/add_1_grad/tuple/control_dependency_1loss/Exp*
T0*#
_output_shapes
:џџџџџџџџџ
m
gradients/loss/pow_1_grad/ShapeShapeloss/pos_items*
T0*
out_type0*
_output_shapes
:
d
!gradients/loss/pow_1_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_1_grad/Shape!gradients/loss/pow_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/pow_1_grad/mulMulgradients/loss/Sum_3_grad/Tileloss/pow_1/y*
T0*'
_output_shapes
:џџџџџџџџџ

d
gradients/loss/pow_1_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
t
gradients/loss/pow_1_grad/subSubloss/pow_1/ygradients/loss/pow_1_grad/sub/y*
T0*
_output_shapes
: 

gradients/loss/pow_1_grad/PowPowloss/pos_itemsgradients/loss/pow_1_grad/sub*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_1_grad/mul_1Mulgradients/loss/pow_1_grad/mulgradients/loss/pow_1_grad/Pow*
T0*'
_output_shapes
:џџџџџџџџџ

Ж
gradients/loss/pow_1_grad/SumSumgradients/loss/pow_1_grad/mul_1/gradients/loss/pow_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ќ
!gradients/loss/pow_1_grad/ReshapeReshapegradients/loss/pow_1_grad/Sumgradients/loss/pow_1_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

h
#gradients/loss/pow_1_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

!gradients/loss/pow_1_grad/GreaterGreaterloss/pos_items#gradients/loss/pow_1_grad/Greater/y*
T0*'
_output_shapes
:џџџџџџџџџ

f
gradients/loss/pow_1_grad/LogLogloss/pos_items*
T0*'
_output_shapes
:џџџџџџџџџ

s
$gradients/loss/pow_1_grad/zeros_like	ZerosLikeloss/pos_items*
T0*'
_output_shapes
:џџџџџџџџџ

Ф
 gradients/loss/pow_1_grad/SelectSelect!gradients/loss/pow_1_grad/Greatergradients/loss/pow_1_grad/Log$gradients/loss/pow_1_grad/zeros_like*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_1_grad/mul_2Mulgradients/loss/Sum_3_grad/Tile
loss/pow_1*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_1_grad/mul_3Mulgradients/loss/pow_1_grad/mul_2 gradients/loss/pow_1_grad/Select*
T0*'
_output_shapes
:џџџџџџџџџ

К
gradients/loss/pow_1_grad/Sum_1Sumgradients/loss/pow_1_grad/mul_31gradients/loss/pow_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/pow_1_grad/Reshape_1Reshapegradients/loss/pow_1_grad/Sum_1!gradients/loss/pow_1_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_1_grad/tuple/group_depsNoOp"^gradients/loss/pow_1_grad/Reshape$^gradients/loss/pow_1_grad/Reshape_1
і
2gradients/loss/pow_1_grad/tuple/control_dependencyIdentity!gradients/loss/pow_1_grad/Reshape+^gradients/loss/pow_1_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

ы
4gradients/loss/pow_1_grad/tuple/control_dependency_1Identity#gradients/loss/pow_1_grad/Reshape_1+^gradients/loss/pow_1_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/pow_1_grad/Reshape_1*
T0*
_output_shapes
: 
m
gradients/loss/Neg_grad/NegNeggradients/loss/Exp_grad/mul*
T0*#
_output_shapes
:џџџџџџџџџ
g
gradients/loss/add_grad/ShapeShape
loss/sub_1*
T0*
out_type0*
_output_shapes
:
g
gradients/loss/add_grad/Shape_1Shapeloss/Sum*
T0*
out_type0*
_output_shapes
:
У
-gradients/loss/add_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_grad/Shapegradients/loss/add_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ў
gradients/loss/add_grad/SumSumgradients/loss/Neg_grad/Neg-gradients/loss/add_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ђ
gradients/loss/add_grad/ReshapeReshapegradients/loss/add_grad/Sumgradients/loss/add_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
В
gradients/loss/add_grad/Sum_1Sumgradients/loss/Neg_grad/Neg/gradients/loss/add_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ј
!gradients/loss/add_grad/Reshape_1Reshapegradients/loss/add_grad/Sum_1gradients/loss/add_grad/Shape_1*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
v
(gradients/loss/add_grad/tuple/group_depsNoOp ^gradients/loss/add_grad/Reshape"^gradients/loss/add_grad/Reshape_1
ъ
0gradients/loss/add_grad/tuple/control_dependencyIdentitygradients/loss/add_grad/Reshape)^gradients/loss/add_grad/tuple/group_deps*2
_class(
&$loc:@gradients/loss/add_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
№
2gradients/loss/add_grad/tuple/control_dependency_1Identity!gradients/loss/add_grad/Reshape_1)^gradients/loss/add_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_grad/Reshape_1*
T0*#
_output_shapes
:џџџџџџџџџ
q
gradients/loss/sub_1_grad/ShapeShapeloss/pos_item_bias*
T0*
out_type0*
_output_shapes
:
s
!gradients/loss/sub_1_grad/Shape_1Shapeloss/neg_item_bias*
T0*
out_type0*
_output_shapes
:
Щ
/gradients/loss/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_1_grad/Shape!gradients/loss/sub_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ч
gradients/loss/sub_1_grad/SumSum0gradients/loss/add_grad/tuple/control_dependency/gradients/loss/sub_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ј
!gradients/loss/sub_1_grad/ReshapeReshapegradients/loss/sub_1_grad/Sumgradients/loss/sub_1_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
Ы
gradients/loss/sub_1_grad/Sum_1Sum0gradients/loss/add_grad/tuple/control_dependency1gradients/loss/sub_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
h
gradients/loss/sub_1_grad/NegNeggradients/loss/sub_1_grad/Sum_1*
T0*
_output_shapes
:
Ќ
#gradients/loss/sub_1_grad/Reshape_1Reshapegradients/loss/sub_1_grad/Neg!gradients/loss/sub_1_grad/Shape_1*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
|
*gradients/loss/sub_1_grad/tuple/group_depsNoOp"^gradients/loss/sub_1_grad/Reshape$^gradients/loss/sub_1_grad/Reshape_1
ђ
2gradients/loss/sub_1_grad/tuple/control_dependencyIdentity!gradients/loss/sub_1_grad/Reshape+^gradients/loss/sub_1_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/sub_1_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
ј
4gradients/loss/sub_1_grad/tuple/control_dependency_1Identity#gradients/loss/sub_1_grad/Reshape_1+^gradients/loss/sub_1_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/sub_1_grad/Reshape_1*
T0*#
_output_shapes
:џџџџџџџџџ
e
gradients/loss/Sum_grad/ShapeShapeloss/mul*
T0*
out_type0*
_output_shapes
:
^
gradients/loss/Sum_grad/SizeConst*
value	B :*
dtype0*
_output_shapes
: 
}
gradients/loss/Sum_grad/addAddloss/Sum/reduction_indicesgradients/loss/Sum_grad/Size*
T0*
_output_shapes
: 

gradients/loss/Sum_grad/modFloorModgradients/loss/Sum_grad/addgradients/loss/Sum_grad/Size*
T0*
_output_shapes
: 
b
gradients/loss/Sum_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
e
#gradients/loss/Sum_grad/range/startConst*
value	B : *
dtype0*
_output_shapes
: 
e
#gradients/loss/Sum_grad/range/deltaConst*
value	B :*
dtype0*
_output_shapes
: 
Ж
gradients/loss/Sum_grad/rangeRange#gradients/loss/Sum_grad/range/startgradients/loss/Sum_grad/Size#gradients/loss/Sum_grad/range/delta*

Tidx0*
_output_shapes
:
d
"gradients/loss/Sum_grad/Fill/valueConst*
value	B :*
dtype0*
_output_shapes
: 

gradients/loss/Sum_grad/FillFillgradients/loss/Sum_grad/Shape_1"gradients/loss/Sum_grad/Fill/value*
T0*
_output_shapes
: 
ц
%gradients/loss/Sum_grad/DynamicStitchDynamicStitchgradients/loss/Sum_grad/rangegradients/loss/Sum_grad/modgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Fill*
N*
T0*#
_output_shapes
:џџџџџџџџџ
c
!gradients/loss/Sum_grad/Maximum/yConst*
value	B :*
dtype0*
_output_shapes
: 
Ђ
gradients/loss/Sum_grad/MaximumMaximum%gradients/loss/Sum_grad/DynamicStitch!gradients/loss/Sum_grad/Maximum/y*
T0*#
_output_shapes
:џџџџџџџџџ

 gradients/loss/Sum_grad/floordivFloorDivgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Maximum*
T0*
_output_shapes
:
Ж
gradients/loss/Sum_grad/ReshapeReshape2gradients/loss/add_grad/tuple/control_dependency_1%gradients/loss/Sum_grad/DynamicStitch*
T0*
Tshape0*
_output_shapes
:
Ћ
gradients/loss/Sum_grad/TileTilegradients/loss/Sum_grad/Reshape gradients/loss/Sum_grad/floordiv*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

ы
gradients/AddNAddN2gradients/loss/pow_2_grad/tuple/control_dependency2gradients/loss/sub_1_grad/tuple/control_dependency*
N*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ

'gradients/loss/pos_item_bias_grad/ShapeConst*&
_class
loc:@variables/item_bias*
valueB:э*
dtype0*
_output_shapes
:

&gradients/loss/pos_item_bias_grad/SizeSizeplaceholders/sampled_pos_items*
T0*
out_type0*
_output_shapes
: 
r
0gradients/loss/pos_item_bias_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
Х
,gradients/loss/pos_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/pos_item_bias_grad/Size0gradients/loss/pos_item_bias_grad/ExpandDims/dim*
T0*
_output_shapes
:*

Tdim0

5gradients/loss/pos_item_bias_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:

7gradients/loss/pos_item_bias_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:

7gradients/loss/pos_item_bias_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
Ѕ
/gradients/loss/pos_item_bias_grad/strided_sliceStridedSlice'gradients/loss/pos_item_bias_grad/Shape5gradients/loss/pos_item_bias_grad/strided_slice/stack7gradients/loss/pos_item_bias_grad/strided_slice/stack_17gradients/loss/pos_item_bias_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
: *
end_mask*

begin_mask 
o
-gradients/loss/pos_item_bias_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ќ
(gradients/loss/pos_item_bias_grad/concatConcatV2,gradients/loss/pos_item_bias_grad/ExpandDims/gradients/loss/pos_item_bias_grad/strided_slice-gradients/loss/pos_item_bias_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Њ
)gradients/loss/pos_item_bias_grad/ReshapeReshapegradients/AddN(gradients/loss/pos_item_bias_grad/concat*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
Р
+gradients/loss/pos_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_pos_items,gradients/loss/pos_item_bias_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
я
gradients/AddN_1AddN2gradients/loss/pow_4_grad/tuple/control_dependency4gradients/loss/sub_1_grad/tuple/control_dependency_1*
N*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ

'gradients/loss/neg_item_bias_grad/ShapeConst*&
_class
loc:@variables/item_bias*
valueB:э*
dtype0*
_output_shapes
:

&gradients/loss/neg_item_bias_grad/SizeSizeplaceholders/sampled_neg_items*
T0*
out_type0*
_output_shapes
: 
r
0gradients/loss/neg_item_bias_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
Х
,gradients/loss/neg_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/neg_item_bias_grad/Size0gradients/loss/neg_item_bias_grad/ExpandDims/dim*
T0*
_output_shapes
:*

Tdim0

5gradients/loss/neg_item_bias_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:

7gradients/loss/neg_item_bias_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:

7gradients/loss/neg_item_bias_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
Ѕ
/gradients/loss/neg_item_bias_grad/strided_sliceStridedSlice'gradients/loss/neg_item_bias_grad/Shape5gradients/loss/neg_item_bias_grad/strided_slice/stack7gradients/loss/neg_item_bias_grad/strided_slice/stack_17gradients/loss/neg_item_bias_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
: *
end_mask*

begin_mask 
o
-gradients/loss/neg_item_bias_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ќ
(gradients/loss/neg_item_bias_grad/concatConcatV2,gradients/loss/neg_item_bias_grad/ExpandDims/gradients/loss/neg_item_bias_grad/strided_slice-gradients/loss/neg_item_bias_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Ќ
)gradients/loss/neg_item_bias_grad/ReshapeReshapegradients/AddN_1(gradients/loss/neg_item_bias_grad/concat*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
Р
+gradients/loss/neg_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_neg_items,gradients/loss/neg_item_bias_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
g
gradients/loss/mul_grad/ShapeShape
loss/users*
T0*
out_type0*
_output_shapes
:
g
gradients/loss/mul_grad/Shape_1Shapeloss/sub*
T0*
out_type0*
_output_shapes
:
У
-gradients/loss/mul_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_grad/Shapegradients/loss/mul_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
|
gradients/loss/mul_grad/mulMulgradients/loss/Sum_grad/Tileloss/sub*
T0*'
_output_shapes
:џџџџџџџџџ

Ў
gradients/loss/mul_grad/SumSumgradients/loss/mul_grad/mul-gradients/loss/mul_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
І
gradients/loss/mul_grad/ReshapeReshapegradients/loss/mul_grad/Sumgradients/loss/mul_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/mul_grad/mul_1Mul
loss/usersgradients/loss/Sum_grad/Tile*
T0*'
_output_shapes
:џџџџџџџџџ

Д
gradients/loss/mul_grad/Sum_1Sumgradients/loss/mul_grad/mul_1/gradients/loss/mul_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ќ
!gradients/loss/mul_grad/Reshape_1Reshapegradients/loss/mul_grad/Sum_1gradients/loss/mul_grad/Shape_1*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

v
(gradients/loss/mul_grad/tuple/group_depsNoOp ^gradients/loss/mul_grad/Reshape"^gradients/loss/mul_grad/Reshape_1
ю
0gradients/loss/mul_grad/tuple/control_dependencyIdentitygradients/loss/mul_grad/Reshape)^gradients/loss/mul_grad/tuple/group_deps*2
_class(
&$loc:@gradients/loss/mul_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

є
2gradients/loss/mul_grad/tuple/control_dependency_1Identity!gradients/loss/mul_grad/Reshape_1)^gradients/loss/mul_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/mul_grad/Reshape_1*
T0*'
_output_shapes
:џџџџџџџџџ

W
gradients/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
Ь
gradients/concatConcatV2)gradients/loss/pos_item_bias_grad/Reshape)gradients/loss/neg_item_bias_grad/Reshapegradients/concat/axis*
N*

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
Y
gradients/concat_1/axisConst*
value	B : *
dtype0*
_output_shapes
: 
д
gradients/concat_1ConcatV2+gradients/loss/pos_item_bias_grad/Reshape_1+gradients/loss/neg_item_bias_grad/Reshape_1gradients/concat_1/axis*
N*

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
ы
gradients/AddN_2AddN0gradients/loss/pow_grad/tuple/control_dependency0gradients/loss/mul_grad/tuple/control_dependency*
N*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/users_grad/ShapeConst*)
_class
loc:@variables/user_factors*
valueB"  
   *
dtype0*
_output_shapes
:
s
gradients/loss/users_grad/SizeSizeplaceholders/sampled_users*
T0*
out_type0*
_output_shapes
: 
j
(gradients/loss/users_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
­
$gradients/loss/users_grad/ExpandDims
ExpandDimsgradients/loss/users_grad/Size(gradients/loss/users_grad/ExpandDims/dim*
T0*
_output_shapes
:*

Tdim0
w
-gradients/loss/users_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:
y
/gradients/loss/users_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:
y
/gradients/loss/users_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
џ
'gradients/loss/users_grad/strided_sliceStridedSlicegradients/loss/users_grad/Shape-gradients/loss/users_grad/strided_slice/stack/gradients/loss/users_grad/strided_slice/stack_1/gradients/loss/users_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
:*
end_mask*

begin_mask 
g
%gradients/loss/users_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
м
 gradients/loss/users_grad/concatConcatV2$gradients/loss/users_grad/ExpandDims'gradients/loss/users_grad/strided_slice%gradients/loss/users_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Љ
!gradients/loss/users_grad/ReshapeReshapegradients/AddN_2 gradients/loss/users_grad/concat*
T0*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Ќ
#gradients/loss/users_grad/Reshape_1Reshapeplaceholders/sampled_users$gradients/loss/users_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
k
gradients/loss/sub_grad/ShapeShapeloss/pos_items*
T0*
out_type0*
_output_shapes
:
m
gradients/loss/sub_grad/Shape_1Shapeloss/neg_items*
T0*
out_type0*
_output_shapes
:
У
-gradients/loss/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_grad/Shapegradients/loss/sub_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Х
gradients/loss/sub_grad/SumSum2gradients/loss/mul_grad/tuple/control_dependency_1-gradients/loss/sub_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
І
gradients/loss/sub_grad/ReshapeReshapegradients/loss/sub_grad/Sumgradients/loss/sub_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

Щ
gradients/loss/sub_grad/Sum_1Sum2gradients/loss/mul_grad/tuple/control_dependency_1/gradients/loss/sub_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
d
gradients/loss/sub_grad/NegNeggradients/loss/sub_grad/Sum_1*
T0*
_output_shapes
:
Њ
!gradients/loss/sub_grad/Reshape_1Reshapegradients/loss/sub_grad/Neggradients/loss/sub_grad/Shape_1*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

v
(gradients/loss/sub_grad/tuple/group_depsNoOp ^gradients/loss/sub_grad/Reshape"^gradients/loss/sub_grad/Reshape_1
ю
0gradients/loss/sub_grad/tuple/control_dependencyIdentitygradients/loss/sub_grad/Reshape)^gradients/loss/sub_grad/tuple/group_deps*2
_class(
&$loc:@gradients/loss/sub_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

є
2gradients/loss/sub_grad/tuple/control_dependency_1Identity!gradients/loss/sub_grad/Reshape_1)^gradients/loss/sub_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/sub_grad/Reshape_1*
T0*'
_output_shapes
:џџџџџџџџџ

я
gradients/AddN_3AddN2gradients/loss/pow_1_grad/tuple/control_dependency0gradients/loss/sub_grad/tuple/control_dependency*
N*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ


#gradients/loss/pos_items_grad/ShapeConst*)
_class
loc:@variables/item_factors*
valueB"m  
   *
dtype0*
_output_shapes
:
{
"gradients/loss/pos_items_grad/SizeSizeplaceholders/sampled_pos_items*
T0*
out_type0*
_output_shapes
: 
n
,gradients/loss/pos_items_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
Й
(gradients/loss/pos_items_grad/ExpandDims
ExpandDims"gradients/loss/pos_items_grad/Size,gradients/loss/pos_items_grad/ExpandDims/dim*
T0*
_output_shapes
:*

Tdim0
{
1gradients/loss/pos_items_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:
}
3gradients/loss/pos_items_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:
}
3gradients/loss/pos_items_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:

+gradients/loss/pos_items_grad/strided_sliceStridedSlice#gradients/loss/pos_items_grad/Shape1gradients/loss/pos_items_grad/strided_slice/stack3gradients/loss/pos_items_grad/strided_slice/stack_13gradients/loss/pos_items_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
:*
end_mask*

begin_mask 
k
)gradients/loss/pos_items_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ь
$gradients/loss/pos_items_grad/concatConcatV2(gradients/loss/pos_items_grad/ExpandDims+gradients/loss/pos_items_grad/strided_slice)gradients/loss/pos_items_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Б
%gradients/loss/pos_items_grad/ReshapeReshapegradients/AddN_3$gradients/loss/pos_items_grad/concat*
T0*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
И
'gradients/loss/pos_items_grad/Reshape_1Reshapeplaceholders/sampled_pos_items(gradients/loss/pos_items_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
ё
gradients/AddN_4AddN2gradients/loss/pow_3_grad/tuple/control_dependency2gradients/loss/sub_grad/tuple/control_dependency_1*
N*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ


#gradients/loss/neg_items_grad/ShapeConst*)
_class
loc:@variables/item_factors*
valueB"m  
   *
dtype0*
_output_shapes
:
{
"gradients/loss/neg_items_grad/SizeSizeplaceholders/sampled_neg_items*
T0*
out_type0*
_output_shapes
: 
n
,gradients/loss/neg_items_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
Й
(gradients/loss/neg_items_grad/ExpandDims
ExpandDims"gradients/loss/neg_items_grad/Size,gradients/loss/neg_items_grad/ExpandDims/dim*
T0*
_output_shapes
:*

Tdim0
{
1gradients/loss/neg_items_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:
}
3gradients/loss/neg_items_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:
}
3gradients/loss/neg_items_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:

+gradients/loss/neg_items_grad/strided_sliceStridedSlice#gradients/loss/neg_items_grad/Shape1gradients/loss/neg_items_grad/strided_slice/stack3gradients/loss/neg_items_grad/strided_slice/stack_13gradients/loss/neg_items_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
:*
end_mask*

begin_mask 
k
)gradients/loss/neg_items_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ь
$gradients/loss/neg_items_grad/concatConcatV2(gradients/loss/neg_items_grad/ExpandDims+gradients/loss/neg_items_grad/strided_slice)gradients/loss/neg_items_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Б
%gradients/loss/neg_items_grad/ReshapeReshapegradients/AddN_4$gradients/loss/neg_items_grad/concat*
T0*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
И
'gradients/loss/neg_items_grad/Reshape_1Reshapeplaceholders/sampled_neg_items(gradients/loss/neg_items_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
Y
gradients/concat_2/axisConst*
value	B : *
dtype0*
_output_shapes
: 
е
gradients/concat_2ConcatV2%gradients/loss/pos_items_grad/Reshape%gradients/loss/neg_items_grad/Reshapegradients/concat_2/axis*
N*

Tidx0*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Y
gradients/concat_3/axisConst*
value	B : *
dtype0*
_output_shapes
: 
Ь
gradients/concat_3ConcatV2'gradients/loss/pos_items_grad/Reshape_1'gradients/loss/neg_items_grad/Reshape_1gradients/concat_3/axis*
N*

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
b
GradientDescent/learning_rateConst*
valueB
 *ЭЬЬ=*
dtype0*
_output_shapes
: 
р
1GradientDescent/update_variables/user_factors/mulMul!gradients/loss/users_grad/ReshapeGradientDescent/learning_rate*)
_class
loc:@variables/user_factors*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Ў
8GradientDescent/update_variables/user_factors/ScatterSub
ScatterSubvariables/user_factors#gradients/loss/users_grad/Reshape_11GradientDescent/update_variables/user_factors/mul*
Tindices0*
use_locking( *
T0*)
_class
loc:@variables/user_factors*
_output_shapes
:	

б
1GradientDescent/update_variables/item_factors/mulMulgradients/concat_2GradientDescent/learning_rate*)
_class
loc:@variables/item_factors*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ

8GradientDescent/update_variables/item_factors/ScatterSub
ScatterSubvariables/item_factorsgradients/concat_31GradientDescent/update_variables/item_factors/mul*
Tindices0*
use_locking( *
T0*)
_class
loc:@variables/item_factors*
_output_shapes
:	э

М
.GradientDescent/update_variables/item_bias/mulMulgradients/concatGradientDescent/learning_rate*&
_class
loc:@variables/item_bias*
T0*#
_output_shapes
:џџџџџџџџџ

5GradientDescent/update_variables/item_bias/ScatterSub
ScatterSubvariables/item_biasgradients/concat_1.GradientDescent/update_variables/item_bias/mul*
Tindices0*
use_locking( *
T0*&
_class
loc:@variables/item_bias*
_output_shapes	
:э
Х
GradientDescentNoOp9^GradientDescent/update_variables/user_factors/ScatterSub9^GradientDescent/update_variables/item_factors/ScatterSub6^GradientDescent/update_variables/item_bias/ScatterSub
R
loss_1/tagsConst*
valueB Bloss_1*
dtype0*
_output_shapes
: 
Q
loss_1ScalarSummaryloss_1/tags
loss/sub_2*
T0*
_output_shapes
: 
K
Merge/MergeSummaryMergeSummaryloss_1*
N*
_output_shapes
: 
i
initNoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign"RцwЦ"     №	К-щ^жAJЙХ
ЧЅ
9
Add
x"T
y"T
z"T"
Ttype:
2	
S
AddN
inputs"T*N
sum"T"
Nint(0"
Ttype:
2	
x
Assign
ref"T

value"T

output_ref"T"	
Ttype"
validate_shapebool("
use_lockingbool(
R
BroadcastGradientArgs
s0"T
s1"T
r0"T
r1"T"
Ttype0:
2	
h
ConcatV2
values"T*N
axis"Tidx
output"T"
Nint(0"	
Ttype"
Tidxtype0:
2	
8
Const
output"dtype"
valuetensor"
dtypetype
S
DynamicStitch
indices*N
data"T*N
merged"T"
Nint(0"	
Ttype
+
Exp
x"T
y"T"
Ttype:	
2
W

ExpandDims

input"T
dim"Tdim
output"T"	
Ttype"
Tdimtype0:
2	
4
Fill
dims

value"T
output"T"	
Ttype
>
FloorDiv
x"T
y"T
z"T"
Ttype:
2	
7
FloorMod
x"T
y"T
z"T"
Ttype:
2	

Gather
params"Tparams
indices"Tindices
output"Tparams"
validate_indicesbool("
Tparamstype"
Tindicestype:
2	
:
Greater
x"T
y"T
z
"
Ttype:
2		
.
Identity

input"T
output"T"	
Ttype
+
Log
x"T
y"T"
Ttype:	
2
:
Maximum
x"T
y"T
z"T"
Ttype:	
2	
8
MergeSummary
inputs*N
summary"
Nint(0
<
Mul
x"T
y"T
z"T"
Ttype:
2	
-
Neg
x"T
y"T"
Ttype:
	2	

NoOp
A
Placeholder
output"dtype"
dtypetype"
shapeshape: 
5
Pow
x"T
y"T
z"T"
Ttype:
	2	
`
Range
start"Tidx
limit"Tidx
delta"Tidx
output"Tidx"
Tidxtype0:
2	
4

Reciprocal
x"T
y"T"
Ttype:
	2	
[
Reshape
tensor"T
shape"Tshape
output"T"	
Ttype"
Tshapetype0:
2	
M
ScalarSummary
tags
values"T
summary"
Ttype:
2		
Ђ

ScatterSub
ref"T
indices"Tindices
updates"T

output_ref"T"
Ttype:
2	"
Tindicestype:
2	"
use_lockingbool( 
?
Select
	condition

t"T
e"T
output"T"	
Ttype
P
Shape

input"T
output"out_type"	
Ttype"
out_typetype0:
2	
O
Size

input"T
output"out_type"	
Ttype"
out_typetype0:
2	
і
StridedSlice

input"T
begin"Index
end"Index
strides"Index
output"T"	
Ttype"
Indextype:
2	"

begin_maskint "
end_maskint "
ellipsis_maskint "
new_axis_maskint "
shrink_axis_maskint 
5
Sub
x"T
y"T
z"T"
Ttype:
	2	

Sum

input"T
reduction_indices"Tidx
output"T"
	keep_dimsbool( "
Ttype:
2	"
Tidxtype0:
2	
c
Tile

input"T
	multiples"
Tmultiples
output"T"	
Ttype"

Tmultiplestype0:
2	

TruncatedNormal

shape"T
output"dtype"
seedint "
seed2int "
dtypetype:
2"
Ttype:
2	
s

VariableV2
ref"dtype"
shapeshape"
dtypetype"
	containerstring "
shared_namestring 
&
	ZerosLike
x"T
y"T"	
Ttype*1.1.02v1.1.0-rc0-61-g1ec6ed5ѓЇ
h
placeholders/sampled_usersPlaceholder*
dtype0*
shape: *#
_output_shapes
:џџџџџџџџџ
l
placeholders/sampled_pos_itemsPlaceholder*
dtype0*
shape: *#
_output_shapes
:џџџџџџџџџ
l
placeholders/sampled_neg_itemsPlaceholder*
dtype0*
shape: *#
_output_shapes
:џџџџџџџџџ
q
 variables/truncated_normal/shapeConst*
valueB"  
   *
dtype0*
_output_shapes
:
d
variables/truncated_normal/meanConst*
valueB
 *    *
dtype0*
_output_shapes
: 
f
!variables/truncated_normal/stddevConst*
valueB
 *шЁ>*
dtype0*
_output_shapes
: 
Г
*variables/truncated_normal/TruncatedNormalTruncatedNormal variables/truncated_normal/shape*
dtype0*
T0*
seedБџх)*
seed2в	*
_output_shapes
:	


variables/truncated_normal/mulMul*variables/truncated_normal/TruncatedNormal!variables/truncated_normal/stddev*
T0*
_output_shapes
:	


variables/truncated_normalAddvariables/truncated_normal/mulvariables/truncated_normal/mean*
T0*
_output_shapes
:	

s
"variables/truncated_normal_1/shapeConst*
valueB"m  
   *
dtype0*
_output_shapes
:
f
!variables/truncated_normal_1/meanConst*
valueB
 *    *
dtype0*
_output_shapes
: 
h
#variables/truncated_normal_1/stddevConst*
valueB
 *шЁ>*
dtype0*
_output_shapes
: 
З
,variables/truncated_normal_1/TruncatedNormalTruncatedNormal"variables/truncated_normal_1/shape*
dtype0*
T0*
seedБџх)*
seed2в	*
_output_shapes
:	э

Є
 variables/truncated_normal_1/mulMul,variables/truncated_normal_1/TruncatedNormal#variables/truncated_normal_1/stddev*
T0*
_output_shapes
:	э


variables/truncated_normal_1Add variables/truncated_normal_1/mul!variables/truncated_normal_1/mean*
T0*
_output_shapes
:	э


variables/user_factors
VariableV2*
	container *
shared_name *
dtype0*
shape:	
*
_output_shapes
:	

й
variables/user_factors/AssignAssignvariables/user_factorsvariables/truncated_normal*
use_locking(*)
_class
loc:@variables/user_factors*
T0*
validate_shape(*
_output_shapes
:	


variables/user_factors/readIdentityvariables/user_factors*)
_class
loc:@variables/user_factors*
T0*
_output_shapes
:	


variables/item_factors
VariableV2*
	container *
shared_name *
dtype0*
shape:	э
*
_output_shapes
:	э

л
variables/item_factors/AssignAssignvariables/item_factorsvariables/truncated_normal_1*
use_locking(*)
_class
loc:@variables/item_factors*
T0*
validate_shape(*
_output_shapes
:	э


variables/item_factors/readIdentityvariables/item_factors*)
_class
loc:@variables/item_factors*
T0*
_output_shapes
:	э

^
variables/zerosConst*
valueBэ*    *
dtype0*
_output_shapes	
:э

variables/item_bias
VariableV2*
	container *
shared_name *
dtype0*
shape:э*
_output_shapes	
:э
С
variables/item_bias/AssignAssignvariables/item_biasvariables/zeros*
use_locking(*&
_class
loc:@variables/item_bias*
T0*
validate_shape(*
_output_shapes	
:э

variables/item_bias/readIdentityvariables/item_bias*&
_class
loc:@variables/item_bias*
T0*
_output_shapes	
:э
­

loss/usersGathervariables/user_factors/readplaceholders/sampled_users*
Tindices0*
validate_indices(*
Tparams0*'
_output_shapes
:џџџџџџџџџ

Е
loss/pos_itemsGathervariables/item_factors/readplaceholders/sampled_pos_items*
Tindices0*
validate_indices(*
Tparams0*'
_output_shapes
:џџџџџџџџџ

Е
loss/neg_itemsGathervariables/item_factors/readplaceholders/sampled_neg_items*
Tindices0*
validate_indices(*
Tparams0*'
_output_shapes
:џџџџџџџџџ

В
loss/pos_item_biasGathervariables/item_bias/readplaceholders/sampled_pos_items*
Tindices0*
validate_indices(*
Tparams0*#
_output_shapes
:џџџџџџџџџ
В
loss/neg_item_biasGathervariables/item_bias/readplaceholders/sampled_neg_items*
Tindices0*
validate_indices(*
Tparams0*#
_output_shapes
:џџџџџџџџџ
a
loss/subSubloss/pos_itemsloss/neg_items*
T0*'
_output_shapes
:џџџџџџџџџ

W
loss/mulMul
loss/usersloss/sub*
T0*'
_output_shapes
:џџџџџџџџџ

\
loss/Sum/reduction_indicesConst*
value	B :*
dtype0*
_output_shapes
: 

loss/SumSumloss/mulloss/Sum/reduction_indices*
	keep_dims( *

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
g

loss/sub_1Subloss/pos_item_biasloss/neg_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
S
loss/addAdd
loss/sub_1loss/Sum*
T0*#
_output_shapes
:џџџџџџџџџ
G
loss/NegNegloss/add*
T0*#
_output_shapes
:џџџџџџџџџ
G
loss/ExpExploss/Neg*
T0*#
_output_shapes
:џџџџџџџџџ
Q
loss/add_1/xConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
W

loss/add_1Addloss/add_1/xloss/Exp*
T0*#
_output_shapes
:џџџџџџџџџ
I
loss/LogLog
loss/add_1*
T0*#
_output_shapes
:џџџџџџџџџ
I

loss/Neg_1Negloss/Log*
T0*#
_output_shapes
:џџџџџџџџџ
T

loss/ConstConst*
valueB: *
dtype0*
_output_shapes
:
g

loss/Sum_1Sum
loss/Neg_1
loss/Const*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
O

loss/pow/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
Y
loss/powPow
loss/users
loss/pow/y*
T0*'
_output_shapes
:џџџџџџџџџ

]
loss/Const_1Const*
valueB"       *
dtype0*
_output_shapes
:
g

loss/Sum_2Sumloss/powloss/Const_1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
Q
loss/mul_1/xConst*
valueB
 *
з#<*
dtype0*
_output_shapes
: 
L

loss/mul_1Mulloss/mul_1/x
loss/Sum_2*
T0*
_output_shapes
: 
Q
loss/pow_1/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
a

loss/pow_1Powloss/pos_itemsloss/pow_1/y*
T0*'
_output_shapes
:џџџџџџџџџ

]
loss/Const_2Const*
valueB"       *
dtype0*
_output_shapes
:
i

loss/Sum_3Sum
loss/pow_1loss/Const_2*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
Q
loss/mul_2/xConst*
valueB
 *
з#<*
dtype0*
_output_shapes
: 
L

loss/mul_2Mulloss/mul_2/x
loss/Sum_3*
T0*
_output_shapes
: 
Q
loss/pow_2/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
a

loss/pow_2Powloss/pos_item_biasloss/pow_2/y*
T0*#
_output_shapes
:џџџџџџџџџ
V
loss/Const_3Const*
valueB: *
dtype0*
_output_shapes
:
i

loss/Sum_4Sum
loss/pow_2loss/Const_3*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
J

loss/add_2Add
loss/mul_2
loss/Sum_4*
T0*
_output_shapes
: 
Q
loss/pow_3/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
a

loss/pow_3Powloss/neg_itemsloss/pow_3/y*
T0*'
_output_shapes
:џџџџџџџџџ

]
loss/Const_4Const*
valueB"       *
dtype0*
_output_shapes
:
i

loss/Sum_5Sum
loss/pow_3loss/Const_4*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
Q
loss/mul_3/xConst*
valueB
 *
з#<*
dtype0*
_output_shapes
: 
L

loss/mul_3Mulloss/mul_3/x
loss/Sum_5*
T0*
_output_shapes
: 
Q
loss/pow_4/yConst*
valueB
 *   @*
dtype0*
_output_shapes
: 
a

loss/pow_4Powloss/neg_item_biasloss/pow_4/y*
T0*#
_output_shapes
:џџџџџџџџџ
V
loss/Const_5Const*
valueB: *
dtype0*
_output_shapes
:
i

loss/Sum_6Sum
loss/pow_4loss/Const_5*
	keep_dims( *

Tidx0*
T0*
_output_shapes
: 
J

loss/add_3Add
loss/mul_3
loss/Sum_6*
T0*
_output_shapes
: 
J

loss/add_4Add
loss/mul_1
loss/add_2*
T0*
_output_shapes
: 
J

loss/add_5Add
loss/add_4
loss/add_3*
T0*
_output_shapes
: 
J

loss/sub_2Sub
loss/add_5
loss/Sum_1*
T0*
_output_shapes
: 
R
gradients/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
T
gradients/ConstConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
Y
gradients/FillFillgradients/Shapegradients/Const*
T0*
_output_shapes
: 
b
gradients/loss/sub_2_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/sub_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_2_grad/Shape!gradients/loss/sub_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ѕ
gradients/loss/sub_2_grad/SumSumgradients/Fill/gradients/loss/sub_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/sub_2_grad/ReshapeReshapegradients/loss/sub_2_grad/Sumgradients/loss/sub_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Љ
gradients/loss/sub_2_grad/Sum_1Sumgradients/Fill1gradients/loss/sub_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
h
gradients/loss/sub_2_grad/NegNeggradients/loss/sub_2_grad/Sum_1*
T0*
_output_shapes
:

#gradients/loss/sub_2_grad/Reshape_1Reshapegradients/loss/sub_2_grad/Neg!gradients/loss/sub_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/sub_2_grad/tuple/group_depsNoOp"^gradients/loss/sub_2_grad/Reshape$^gradients/loss/sub_2_grad/Reshape_1
х
2gradients/loss/sub_2_grad/tuple/control_dependencyIdentity!gradients/loss/sub_2_grad/Reshape+^gradients/loss/sub_2_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/sub_2_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/sub_2_grad/tuple/control_dependency_1Identity#gradients/loss/sub_2_grad/Reshape_1+^gradients/loss/sub_2_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/sub_2_grad/Reshape_1*
T0*
_output_shapes
: 
b
gradients/loss/add_5_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/add_5_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/add_5_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_5_grad/Shape!gradients/loss/add_5_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Щ
gradients/loss/add_5_grad/SumSum2gradients/loss/sub_2_grad/tuple/control_dependency/gradients/loss/add_5_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/add_5_grad/ReshapeReshapegradients/loss/add_5_grad/Sumgradients/loss/add_5_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Э
gradients/loss/add_5_grad/Sum_1Sum2gradients/loss/sub_2_grad/tuple/control_dependency1gradients/loss/add_5_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/add_5_grad/Reshape_1Reshapegradients/loss/add_5_grad/Sum_1!gradients/loss/add_5_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_5_grad/tuple/group_depsNoOp"^gradients/loss/add_5_grad/Reshape$^gradients/loss/add_5_grad/Reshape_1
х
2gradients/loss/add_5_grad/tuple/control_dependencyIdentity!gradients/loss/add_5_grad/Reshape+^gradients/loss/add_5_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_5_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/add_5_grad/tuple/control_dependency_1Identity#gradients/loss/add_5_grad/Reshape_1+^gradients/loss/add_5_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/add_5_grad/Reshape_1*
T0*
_output_shapes
: 
q
'gradients/loss/Sum_1_grad/Reshape/shapeConst*
valueB:*
dtype0*
_output_shapes
:
О
!gradients/loss/Sum_1_grad/ReshapeReshape4gradients/loss/sub_2_grad/tuple/control_dependency_1'gradients/loss/Sum_1_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
i
gradients/loss/Sum_1_grad/ShapeShape
loss/Neg_1*
T0*
out_type0*
_output_shapes
:
Њ
gradients/loss/Sum_1_grad/TileTile!gradients/loss/Sum_1_grad/Reshapegradients/loss/Sum_1_grad/Shape*
T0*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ
b
gradients/loss/add_4_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/add_4_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/add_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_4_grad/Shape!gradients/loss/add_4_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Щ
gradients/loss/add_4_grad/SumSum2gradients/loss/add_5_grad/tuple/control_dependency/gradients/loss/add_4_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/add_4_grad/ReshapeReshapegradients/loss/add_4_grad/Sumgradients/loss/add_4_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Э
gradients/loss/add_4_grad/Sum_1Sum2gradients/loss/add_5_grad/tuple/control_dependency1gradients/loss/add_4_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/add_4_grad/Reshape_1Reshapegradients/loss/add_4_grad/Sum_1!gradients/loss/add_4_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_4_grad/tuple/group_depsNoOp"^gradients/loss/add_4_grad/Reshape$^gradients/loss/add_4_grad/Reshape_1
х
2gradients/loss/add_4_grad/tuple/control_dependencyIdentity!gradients/loss/add_4_grad/Reshape+^gradients/loss/add_4_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_4_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/add_4_grad/tuple/control_dependency_1Identity#gradients/loss/add_4_grad/Reshape_1+^gradients/loss/add_4_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/add_4_grad/Reshape_1*
T0*
_output_shapes
: 
b
gradients/loss/add_3_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/add_3_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/add_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_3_grad/Shape!gradients/loss/add_3_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ы
gradients/loss/add_3_grad/SumSum4gradients/loss/add_5_grad/tuple/control_dependency_1/gradients/loss/add_3_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/add_3_grad/ReshapeReshapegradients/loss/add_3_grad/Sumgradients/loss/add_3_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Я
gradients/loss/add_3_grad/Sum_1Sum4gradients/loss/add_5_grad/tuple/control_dependency_11gradients/loss/add_3_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/add_3_grad/Reshape_1Reshapegradients/loss/add_3_grad/Sum_1!gradients/loss/add_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_3_grad/tuple/group_depsNoOp"^gradients/loss/add_3_grad/Reshape$^gradients/loss/add_3_grad/Reshape_1
х
2gradients/loss/add_3_grad/tuple/control_dependencyIdentity!gradients/loss/add_3_grad/Reshape+^gradients/loss/add_3_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_3_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/add_3_grad/tuple/control_dependency_1Identity#gradients/loss/add_3_grad/Reshape_1+^gradients/loss/add_3_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/add_3_grad/Reshape_1*
T0*
_output_shapes
: 
r
gradients/loss/Neg_1_grad/NegNeggradients/loss/Sum_1_grad/Tile*
T0*#
_output_shapes
:џџџџџџџџџ
b
gradients/loss/mul_1_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/mul_1_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_1_grad/Shape!gradients/loss/mul_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/mul_1_grad/mulMul2gradients/loss/add_4_grad/tuple/control_dependency
loss/Sum_2*
T0*
_output_shapes
: 
Д
gradients/loss/mul_1_grad/SumSumgradients/loss/mul_1_grad/mul/gradients/loss/mul_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/mul_1_grad/ReshapeReshapegradients/loss/mul_1_grad/Sumgradients/loss/mul_1_grad/Shape*
T0*
Tshape0*
_output_shapes
: 

gradients/loss/mul_1_grad/mul_1Mulloss/mul_1/x2gradients/loss/add_4_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_1_grad/Sum_1Sumgradients/loss/mul_1_grad/mul_11gradients/loss/mul_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/mul_1_grad/Reshape_1Reshapegradients/loss/mul_1_grad/Sum_1!gradients/loss/mul_1_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/mul_1_grad/tuple/group_depsNoOp"^gradients/loss/mul_1_grad/Reshape$^gradients/loss/mul_1_grad/Reshape_1
х
2gradients/loss/mul_1_grad/tuple/control_dependencyIdentity!gradients/loss/mul_1_grad/Reshape+^gradients/loss/mul_1_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/mul_1_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/mul_1_grad/tuple/control_dependency_1Identity#gradients/loss/mul_1_grad/Reshape_1+^gradients/loss/mul_1_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/mul_1_grad/Reshape_1*
T0*
_output_shapes
: 
b
gradients/loss/add_2_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/add_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/add_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_2_grad/Shape!gradients/loss/add_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ы
gradients/loss/add_2_grad/SumSum4gradients/loss/add_4_grad/tuple/control_dependency_1/gradients/loss/add_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/add_2_grad/ReshapeReshapegradients/loss/add_2_grad/Sumgradients/loss/add_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Я
gradients/loss/add_2_grad/Sum_1Sum4gradients/loss/add_4_grad/tuple/control_dependency_11gradients/loss/add_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/add_2_grad/Reshape_1Reshapegradients/loss/add_2_grad/Sum_1!gradients/loss/add_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_2_grad/tuple/group_depsNoOp"^gradients/loss/add_2_grad/Reshape$^gradients/loss/add_2_grad/Reshape_1
х
2gradients/loss/add_2_grad/tuple/control_dependencyIdentity!gradients/loss/add_2_grad/Reshape+^gradients/loss/add_2_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_2_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/add_2_grad/tuple/control_dependency_1Identity#gradients/loss/add_2_grad/Reshape_1+^gradients/loss/add_2_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/add_2_grad/Reshape_1*
T0*
_output_shapes
: 
b
gradients/loss/mul_3_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/mul_3_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_3_grad/Shape!gradients/loss/mul_3_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/mul_3_grad/mulMul2gradients/loss/add_3_grad/tuple/control_dependency
loss/Sum_5*
T0*
_output_shapes
: 
Д
gradients/loss/mul_3_grad/SumSumgradients/loss/mul_3_grad/mul/gradients/loss/mul_3_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/mul_3_grad/ReshapeReshapegradients/loss/mul_3_grad/Sumgradients/loss/mul_3_grad/Shape*
T0*
Tshape0*
_output_shapes
: 

gradients/loss/mul_3_grad/mul_1Mulloss/mul_3/x2gradients/loss/add_3_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_3_grad/Sum_1Sumgradients/loss/mul_3_grad/mul_11gradients/loss/mul_3_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/mul_3_grad/Reshape_1Reshapegradients/loss/mul_3_grad/Sum_1!gradients/loss/mul_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/mul_3_grad/tuple/group_depsNoOp"^gradients/loss/mul_3_grad/Reshape$^gradients/loss/mul_3_grad/Reshape_1
х
2gradients/loss/mul_3_grad/tuple/control_dependencyIdentity!gradients/loss/mul_3_grad/Reshape+^gradients/loss/mul_3_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/mul_3_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/mul_3_grad/tuple/control_dependency_1Identity#gradients/loss/mul_3_grad/Reshape_1+^gradients/loss/mul_3_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/mul_3_grad/Reshape_1*
T0*
_output_shapes
: 
q
'gradients/loss/Sum_6_grad/Reshape/shapeConst*
valueB:*
dtype0*
_output_shapes
:
О
!gradients/loss/Sum_6_grad/ReshapeReshape4gradients/loss/add_3_grad/tuple/control_dependency_1'gradients/loss/Sum_6_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
i
gradients/loss/Sum_6_grad/ShapeShape
loss/pow_4*
T0*
out_type0*
_output_shapes
:
Њ
gradients/loss/Sum_6_grad/TileTile!gradients/loss/Sum_6_grad/Reshapegradients/loss/Sum_6_grad/Shape*
T0*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ

"gradients/loss/Log_grad/Reciprocal
Reciprocal
loss/add_1^gradients/loss/Neg_1_grad/Neg*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/Log_grad/mulMulgradients/loss/Neg_1_grad/Neg"gradients/loss/Log_grad/Reciprocal*
T0*#
_output_shapes
:џџџџџџџџџ
x
'gradients/loss/Sum_2_grad/Reshape/shapeConst*
valueB"      *
dtype0*
_output_shapes
:
Т
!gradients/loss/Sum_2_grad/ReshapeReshape4gradients/loss/mul_1_grad/tuple/control_dependency_1'gradients/loss/Sum_2_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
g
gradients/loss/Sum_2_grad/ShapeShapeloss/pow*
T0*
out_type0*
_output_shapes
:
Ў
gradients/loss/Sum_2_grad/TileTile!gradients/loss/Sum_2_grad/Reshapegradients/loss/Sum_2_grad/Shape*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

b
gradients/loss/mul_2_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
d
!gradients/loss/mul_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_2_grad/Shape!gradients/loss/mul_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/mul_2_grad/mulMul2gradients/loss/add_2_grad/tuple/control_dependency
loss/Sum_3*
T0*
_output_shapes
: 
Д
gradients/loss/mul_2_grad/SumSumgradients/loss/mul_2_grad/mul/gradients/loss/mul_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/mul_2_grad/ReshapeReshapegradients/loss/mul_2_grad/Sumgradients/loss/mul_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 

gradients/loss/mul_2_grad/mul_1Mulloss/mul_2/x2gradients/loss/add_2_grad/tuple/control_dependency*
T0*
_output_shapes
: 
К
gradients/loss/mul_2_grad/Sum_1Sumgradients/loss/mul_2_grad/mul_11gradients/loss/mul_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/mul_2_grad/Reshape_1Reshapegradients/loss/mul_2_grad/Sum_1!gradients/loss/mul_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/mul_2_grad/tuple/group_depsNoOp"^gradients/loss/mul_2_grad/Reshape$^gradients/loss/mul_2_grad/Reshape_1
х
2gradients/loss/mul_2_grad/tuple/control_dependencyIdentity!gradients/loss/mul_2_grad/Reshape+^gradients/loss/mul_2_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/mul_2_grad/Reshape*
T0*
_output_shapes
: 
ы
4gradients/loss/mul_2_grad/tuple/control_dependency_1Identity#gradients/loss/mul_2_grad/Reshape_1+^gradients/loss/mul_2_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/mul_2_grad/Reshape_1*
T0*
_output_shapes
: 
q
'gradients/loss/Sum_4_grad/Reshape/shapeConst*
valueB:*
dtype0*
_output_shapes
:
О
!gradients/loss/Sum_4_grad/ReshapeReshape4gradients/loss/add_2_grad/tuple/control_dependency_1'gradients/loss/Sum_4_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
i
gradients/loss/Sum_4_grad/ShapeShape
loss/pow_2*
T0*
out_type0*
_output_shapes
:
Њ
gradients/loss/Sum_4_grad/TileTile!gradients/loss/Sum_4_grad/Reshapegradients/loss/Sum_4_grad/Shape*
T0*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ
x
'gradients/loss/Sum_5_grad/Reshape/shapeConst*
valueB"      *
dtype0*
_output_shapes
:
Т
!gradients/loss/Sum_5_grad/ReshapeReshape4gradients/loss/mul_3_grad/tuple/control_dependency_1'gradients/loss/Sum_5_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
i
gradients/loss/Sum_5_grad/ShapeShape
loss/pow_3*
T0*
out_type0*
_output_shapes
:
Ў
gradients/loss/Sum_5_grad/TileTile!gradients/loss/Sum_5_grad/Reshapegradients/loss/Sum_5_grad/Shape*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

q
gradients/loss/pow_4_grad/ShapeShapeloss/neg_item_bias*
T0*
out_type0*
_output_shapes
:
d
!gradients/loss/pow_4_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_4_grad/Shape!gradients/loss/pow_4_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/pow_4_grad/mulMulgradients/loss/Sum_6_grad/Tileloss/pow_4/y*
T0*#
_output_shapes
:џџџџџџџџџ
d
gradients/loss/pow_4_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
t
gradients/loss/pow_4_grad/subSubloss/pow_4/ygradients/loss/pow_4_grad/sub/y*
T0*
_output_shapes
: 

gradients/loss/pow_4_grad/PowPowloss/neg_item_biasgradients/loss/pow_4_grad/sub*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_4_grad/mul_1Mulgradients/loss/pow_4_grad/mulgradients/loss/pow_4_grad/Pow*
T0*#
_output_shapes
:џџџџџџџџџ
Ж
gradients/loss/pow_4_grad/SumSumgradients/loss/pow_4_grad/mul_1/gradients/loss/pow_4_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ј
!gradients/loss/pow_4_grad/ReshapeReshapegradients/loss/pow_4_grad/Sumgradients/loss/pow_4_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
h
#gradients/loss/pow_4_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

!gradients/loss/pow_4_grad/GreaterGreaterloss/neg_item_bias#gradients/loss/pow_4_grad/Greater/y*
T0*#
_output_shapes
:џџџџџџџџџ
f
gradients/loss/pow_4_grad/LogLogloss/neg_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
s
$gradients/loss/pow_4_grad/zeros_like	ZerosLikeloss/neg_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
Р
 gradients/loss/pow_4_grad/SelectSelect!gradients/loss/pow_4_grad/Greatergradients/loss/pow_4_grad/Log$gradients/loss/pow_4_grad/zeros_like*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_4_grad/mul_2Mulgradients/loss/Sum_6_grad/Tile
loss/pow_4*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_4_grad/mul_3Mulgradients/loss/pow_4_grad/mul_2 gradients/loss/pow_4_grad/Select*
T0*#
_output_shapes
:џџџџџџџџџ
К
gradients/loss/pow_4_grad/Sum_1Sumgradients/loss/pow_4_grad/mul_31gradients/loss/pow_4_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/pow_4_grad/Reshape_1Reshapegradients/loss/pow_4_grad/Sum_1!gradients/loss/pow_4_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_4_grad/tuple/group_depsNoOp"^gradients/loss/pow_4_grad/Reshape$^gradients/loss/pow_4_grad/Reshape_1
ђ
2gradients/loss/pow_4_grad/tuple/control_dependencyIdentity!gradients/loss/pow_4_grad/Reshape+^gradients/loss/pow_4_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
ы
4gradients/loss/pow_4_grad/tuple/control_dependency_1Identity#gradients/loss/pow_4_grad/Reshape_1+^gradients/loss/pow_4_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/pow_4_grad/Reshape_1*
T0*
_output_shapes
: 
b
gradients/loss/add_1_grad/ShapeConst*
valueB *
dtype0*
_output_shapes
: 
i
!gradients/loss/add_1_grad/Shape_1Shapeloss/Exp*
T0*
out_type0*
_output_shapes
:
Щ
/gradients/loss/add_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_1_grad/Shape!gradients/loss/add_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
В
gradients/loss/add_1_grad/SumSumgradients/loss/Log_grad/mul/gradients/loss/add_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/add_1_grad/ReshapeReshapegradients/loss/add_1_grad/Sumgradients/loss/add_1_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
Ж
gradients/loss/add_1_grad/Sum_1Sumgradients/loss/Log_grad/mul1gradients/loss/add_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ў
#gradients/loss/add_1_grad/Reshape_1Reshapegradients/loss/add_1_grad/Sum_1!gradients/loss/add_1_grad/Shape_1*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
|
*gradients/loss/add_1_grad/tuple/group_depsNoOp"^gradients/loss/add_1_grad/Reshape$^gradients/loss/add_1_grad/Reshape_1
х
2gradients/loss/add_1_grad/tuple/control_dependencyIdentity!gradients/loss/add_1_grad/Reshape+^gradients/loss/add_1_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_1_grad/Reshape*
T0*
_output_shapes
: 
ј
4gradients/loss/add_1_grad/tuple/control_dependency_1Identity#gradients/loss/add_1_grad/Reshape_1+^gradients/loss/add_1_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/add_1_grad/Reshape_1*
T0*#
_output_shapes
:џџџџџџџџџ
g
gradients/loss/pow_grad/ShapeShape
loss/users*
T0*
out_type0*
_output_shapes
:
b
gradients/loss/pow_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
У
-gradients/loss/pow_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_grad/Shapegradients/loss/pow_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/pow_grad/mulMulgradients/loss/Sum_2_grad/Tile
loss/pow/y*
T0*'
_output_shapes
:џџџџџџџџџ

b
gradients/loss/pow_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
n
gradients/loss/pow_grad/subSub
loss/pow/ygradients/loss/pow_grad/sub/y*
T0*
_output_shapes
: 
}
gradients/loss/pow_grad/PowPow
loss/usersgradients/loss/pow_grad/sub*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_grad/mul_1Mulgradients/loss/pow_grad/mulgradients/loss/pow_grad/Pow*
T0*'
_output_shapes
:џџџџџџџџџ

А
gradients/loss/pow_grad/SumSumgradients/loss/pow_grad/mul_1-gradients/loss/pow_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
І
gradients/loss/pow_grad/ReshapeReshapegradients/loss/pow_grad/Sumgradients/loss/pow_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

f
!gradients/loss/pow_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

gradients/loss/pow_grad/GreaterGreater
loss/users!gradients/loss/pow_grad/Greater/y*
T0*'
_output_shapes
:џџџџџџџџџ

`
gradients/loss/pow_grad/LogLog
loss/users*
T0*'
_output_shapes
:џџџџџџџџџ

m
"gradients/loss/pow_grad/zeros_like	ZerosLike
loss/users*
T0*'
_output_shapes
:џџџџџџџџџ

М
gradients/loss/pow_grad/SelectSelectgradients/loss/pow_grad/Greatergradients/loss/pow_grad/Log"gradients/loss/pow_grad/zeros_like*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_grad/mul_2Mulgradients/loss/Sum_2_grad/Tileloss/pow*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_grad/mul_3Mulgradients/loss/pow_grad/mul_2gradients/loss/pow_grad/Select*
T0*'
_output_shapes
:џџџџџџџџџ

Д
gradients/loss/pow_grad/Sum_1Sumgradients/loss/pow_grad/mul_3/gradients/loss/pow_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:

!gradients/loss/pow_grad/Reshape_1Reshapegradients/loss/pow_grad/Sum_1gradients/loss/pow_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
v
(gradients/loss/pow_grad/tuple/group_depsNoOp ^gradients/loss/pow_grad/Reshape"^gradients/loss/pow_grad/Reshape_1
ю
0gradients/loss/pow_grad/tuple/control_dependencyIdentitygradients/loss/pow_grad/Reshape)^gradients/loss/pow_grad/tuple/group_deps*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

у
2gradients/loss/pow_grad/tuple/control_dependency_1Identity!gradients/loss/pow_grad/Reshape_1)^gradients/loss/pow_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/pow_grad/Reshape_1*
T0*
_output_shapes
: 
x
'gradients/loss/Sum_3_grad/Reshape/shapeConst*
valueB"      *
dtype0*
_output_shapes
:
Т
!gradients/loss/Sum_3_grad/ReshapeReshape4gradients/loss/mul_2_grad/tuple/control_dependency_1'gradients/loss/Sum_3_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
i
gradients/loss/Sum_3_grad/ShapeShape
loss/pow_1*
T0*
out_type0*
_output_shapes
:
Ў
gradients/loss/Sum_3_grad/TileTile!gradients/loss/Sum_3_grad/Reshapegradients/loss/Sum_3_grad/Shape*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

q
gradients/loss/pow_2_grad/ShapeShapeloss/pos_item_bias*
T0*
out_type0*
_output_shapes
:
d
!gradients/loss/pow_2_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_2_grad/Shape!gradients/loss/pow_2_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/pow_2_grad/mulMulgradients/loss/Sum_4_grad/Tileloss/pow_2/y*
T0*#
_output_shapes
:џџџџџџџџџ
d
gradients/loss/pow_2_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
t
gradients/loss/pow_2_grad/subSubloss/pow_2/ygradients/loss/pow_2_grad/sub/y*
T0*
_output_shapes
: 

gradients/loss/pow_2_grad/PowPowloss/pos_item_biasgradients/loss/pow_2_grad/sub*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_2_grad/mul_1Mulgradients/loss/pow_2_grad/mulgradients/loss/pow_2_grad/Pow*
T0*#
_output_shapes
:џџџџџџџџџ
Ж
gradients/loss/pow_2_grad/SumSumgradients/loss/pow_2_grad/mul_1/gradients/loss/pow_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ј
!gradients/loss/pow_2_grad/ReshapeReshapegradients/loss/pow_2_grad/Sumgradients/loss/pow_2_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
h
#gradients/loss/pow_2_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

!gradients/loss/pow_2_grad/GreaterGreaterloss/pos_item_bias#gradients/loss/pow_2_grad/Greater/y*
T0*#
_output_shapes
:џџџџџџџџџ
f
gradients/loss/pow_2_grad/LogLogloss/pos_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
s
$gradients/loss/pow_2_grad/zeros_like	ZerosLikeloss/pos_item_bias*
T0*#
_output_shapes
:џџџџџџџџџ
Р
 gradients/loss/pow_2_grad/SelectSelect!gradients/loss/pow_2_grad/Greatergradients/loss/pow_2_grad/Log$gradients/loss/pow_2_grad/zeros_like*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_2_grad/mul_2Mulgradients/loss/Sum_4_grad/Tile
loss/pow_2*
T0*#
_output_shapes
:џџџџџџџџџ

gradients/loss/pow_2_grad/mul_3Mulgradients/loss/pow_2_grad/mul_2 gradients/loss/pow_2_grad/Select*
T0*#
_output_shapes
:џџџџџџџџџ
К
gradients/loss/pow_2_grad/Sum_1Sumgradients/loss/pow_2_grad/mul_31gradients/loss/pow_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/pow_2_grad/Reshape_1Reshapegradients/loss/pow_2_grad/Sum_1!gradients/loss/pow_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_2_grad/tuple/group_depsNoOp"^gradients/loss/pow_2_grad/Reshape$^gradients/loss/pow_2_grad/Reshape_1
ђ
2gradients/loss/pow_2_grad/tuple/control_dependencyIdentity!gradients/loss/pow_2_grad/Reshape+^gradients/loss/pow_2_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
ы
4gradients/loss/pow_2_grad/tuple/control_dependency_1Identity#gradients/loss/pow_2_grad/Reshape_1+^gradients/loss/pow_2_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/pow_2_grad/Reshape_1*
T0*
_output_shapes
: 
m
gradients/loss/pow_3_grad/ShapeShapeloss/neg_items*
T0*
out_type0*
_output_shapes
:
d
!gradients/loss/pow_3_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_3_grad/Shape!gradients/loss/pow_3_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/pow_3_grad/mulMulgradients/loss/Sum_5_grad/Tileloss/pow_3/y*
T0*'
_output_shapes
:џџџџџџџџџ

d
gradients/loss/pow_3_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
t
gradients/loss/pow_3_grad/subSubloss/pow_3/ygradients/loss/pow_3_grad/sub/y*
T0*
_output_shapes
: 

gradients/loss/pow_3_grad/PowPowloss/neg_itemsgradients/loss/pow_3_grad/sub*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_3_grad/mul_1Mulgradients/loss/pow_3_grad/mulgradients/loss/pow_3_grad/Pow*
T0*'
_output_shapes
:џџџџџџџџџ

Ж
gradients/loss/pow_3_grad/SumSumgradients/loss/pow_3_grad/mul_1/gradients/loss/pow_3_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ќ
!gradients/loss/pow_3_grad/ReshapeReshapegradients/loss/pow_3_grad/Sumgradients/loss/pow_3_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

h
#gradients/loss/pow_3_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

!gradients/loss/pow_3_grad/GreaterGreaterloss/neg_items#gradients/loss/pow_3_grad/Greater/y*
T0*'
_output_shapes
:џџџџџџџџџ

f
gradients/loss/pow_3_grad/LogLogloss/neg_items*
T0*'
_output_shapes
:џџџџџџџџџ

s
$gradients/loss/pow_3_grad/zeros_like	ZerosLikeloss/neg_items*
T0*'
_output_shapes
:џџџџџџџџџ

Ф
 gradients/loss/pow_3_grad/SelectSelect!gradients/loss/pow_3_grad/Greatergradients/loss/pow_3_grad/Log$gradients/loss/pow_3_grad/zeros_like*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_3_grad/mul_2Mulgradients/loss/Sum_5_grad/Tile
loss/pow_3*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_3_grad/mul_3Mulgradients/loss/pow_3_grad/mul_2 gradients/loss/pow_3_grad/Select*
T0*'
_output_shapes
:џџџџџџџџџ

К
gradients/loss/pow_3_grad/Sum_1Sumgradients/loss/pow_3_grad/mul_31gradients/loss/pow_3_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/pow_3_grad/Reshape_1Reshapegradients/loss/pow_3_grad/Sum_1!gradients/loss/pow_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_3_grad/tuple/group_depsNoOp"^gradients/loss/pow_3_grad/Reshape$^gradients/loss/pow_3_grad/Reshape_1
і
2gradients/loss/pow_3_grad/tuple/control_dependencyIdentity!gradients/loss/pow_3_grad/Reshape+^gradients/loss/pow_3_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

ы
4gradients/loss/pow_3_grad/tuple/control_dependency_1Identity#gradients/loss/pow_3_grad/Reshape_1+^gradients/loss/pow_3_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/pow_3_grad/Reshape_1*
T0*
_output_shapes
: 

gradients/loss/Exp_grad/mulMul4gradients/loss/add_1_grad/tuple/control_dependency_1loss/Exp*
T0*#
_output_shapes
:џџџџџџџџџ
m
gradients/loss/pow_1_grad/ShapeShapeloss/pos_items*
T0*
out_type0*
_output_shapes
:
d
!gradients/loss/pow_1_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
Щ
/gradients/loss/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_1_grad/Shape!gradients/loss/pow_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ

gradients/loss/pow_1_grad/mulMulgradients/loss/Sum_3_grad/Tileloss/pow_1/y*
T0*'
_output_shapes
:џџџџџџџџџ

d
gradients/loss/pow_1_grad/sub/yConst*
valueB
 *  ?*
dtype0*
_output_shapes
: 
t
gradients/loss/pow_1_grad/subSubloss/pow_1/ygradients/loss/pow_1_grad/sub/y*
T0*
_output_shapes
: 

gradients/loss/pow_1_grad/PowPowloss/pos_itemsgradients/loss/pow_1_grad/sub*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_1_grad/mul_1Mulgradients/loss/pow_1_grad/mulgradients/loss/pow_1_grad/Pow*
T0*'
_output_shapes
:џџџџџџџџџ

Ж
gradients/loss/pow_1_grad/SumSumgradients/loss/pow_1_grad/mul_1/gradients/loss/pow_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ќ
!gradients/loss/pow_1_grad/ReshapeReshapegradients/loss/pow_1_grad/Sumgradients/loss/pow_1_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

h
#gradients/loss/pow_1_grad/Greater/yConst*
valueB
 *    *
dtype0*
_output_shapes
: 

!gradients/loss/pow_1_grad/GreaterGreaterloss/pos_items#gradients/loss/pow_1_grad/Greater/y*
T0*'
_output_shapes
:џџџџџџџџџ

f
gradients/loss/pow_1_grad/LogLogloss/pos_items*
T0*'
_output_shapes
:џџџџџџџџџ

s
$gradients/loss/pow_1_grad/zeros_like	ZerosLikeloss/pos_items*
T0*'
_output_shapes
:џџџџџџџџџ

Ф
 gradients/loss/pow_1_grad/SelectSelect!gradients/loss/pow_1_grad/Greatergradients/loss/pow_1_grad/Log$gradients/loss/pow_1_grad/zeros_like*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_1_grad/mul_2Mulgradients/loss/Sum_3_grad/Tile
loss/pow_1*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/pow_1_grad/mul_3Mulgradients/loss/pow_1_grad/mul_2 gradients/loss/pow_1_grad/Select*
T0*'
_output_shapes
:џџџџџџџџџ

К
gradients/loss/pow_1_grad/Sum_1Sumgradients/loss/pow_1_grad/mul_31gradients/loss/pow_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ё
#gradients/loss/pow_1_grad/Reshape_1Reshapegradients/loss/pow_1_grad/Sum_1!gradients/loss/pow_1_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_1_grad/tuple/group_depsNoOp"^gradients/loss/pow_1_grad/Reshape$^gradients/loss/pow_1_grad/Reshape_1
і
2gradients/loss/pow_1_grad/tuple/control_dependencyIdentity!gradients/loss/pow_1_grad/Reshape+^gradients/loss/pow_1_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

ы
4gradients/loss/pow_1_grad/tuple/control_dependency_1Identity#gradients/loss/pow_1_grad/Reshape_1+^gradients/loss/pow_1_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/pow_1_grad/Reshape_1*
T0*
_output_shapes
: 
m
gradients/loss/Neg_grad/NegNeggradients/loss/Exp_grad/mul*
T0*#
_output_shapes
:џџџџџџџџџ
g
gradients/loss/add_grad/ShapeShape
loss/sub_1*
T0*
out_type0*
_output_shapes
:
g
gradients/loss/add_grad/Shape_1Shapeloss/Sum*
T0*
out_type0*
_output_shapes
:
У
-gradients/loss/add_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_grad/Shapegradients/loss/add_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ў
gradients/loss/add_grad/SumSumgradients/loss/Neg_grad/Neg-gradients/loss/add_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ђ
gradients/loss/add_grad/ReshapeReshapegradients/loss/add_grad/Sumgradients/loss/add_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
В
gradients/loss/add_grad/Sum_1Sumgradients/loss/Neg_grad/Neg/gradients/loss/add_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ј
!gradients/loss/add_grad/Reshape_1Reshapegradients/loss/add_grad/Sum_1gradients/loss/add_grad/Shape_1*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
v
(gradients/loss/add_grad/tuple/group_depsNoOp ^gradients/loss/add_grad/Reshape"^gradients/loss/add_grad/Reshape_1
ъ
0gradients/loss/add_grad/tuple/control_dependencyIdentitygradients/loss/add_grad/Reshape)^gradients/loss/add_grad/tuple/group_deps*2
_class(
&$loc:@gradients/loss/add_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
№
2gradients/loss/add_grad/tuple/control_dependency_1Identity!gradients/loss/add_grad/Reshape_1)^gradients/loss/add_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/add_grad/Reshape_1*
T0*#
_output_shapes
:џџџџџџџџџ
q
gradients/loss/sub_1_grad/ShapeShapeloss/pos_item_bias*
T0*
out_type0*
_output_shapes
:
s
!gradients/loss/sub_1_grad/Shape_1Shapeloss/neg_item_bias*
T0*
out_type0*
_output_shapes
:
Щ
/gradients/loss/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_1_grad/Shape!gradients/loss/sub_1_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Ч
gradients/loss/sub_1_grad/SumSum0gradients/loss/add_grad/tuple/control_dependency/gradients/loss/sub_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ј
!gradients/loss/sub_1_grad/ReshapeReshapegradients/loss/sub_1_grad/Sumgradients/loss/sub_1_grad/Shape*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
Ы
gradients/loss/sub_1_grad/Sum_1Sum0gradients/loss/add_grad/tuple/control_dependency1gradients/loss/sub_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
h
gradients/loss/sub_1_grad/NegNeggradients/loss/sub_1_grad/Sum_1*
T0*
_output_shapes
:
Ќ
#gradients/loss/sub_1_grad/Reshape_1Reshapegradients/loss/sub_1_grad/Neg!gradients/loss/sub_1_grad/Shape_1*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
|
*gradients/loss/sub_1_grad/tuple/group_depsNoOp"^gradients/loss/sub_1_grad/Reshape$^gradients/loss/sub_1_grad/Reshape_1
ђ
2gradients/loss/sub_1_grad/tuple/control_dependencyIdentity!gradients/loss/sub_1_grad/Reshape+^gradients/loss/sub_1_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/sub_1_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ
ј
4gradients/loss/sub_1_grad/tuple/control_dependency_1Identity#gradients/loss/sub_1_grad/Reshape_1+^gradients/loss/sub_1_grad/tuple/group_deps*6
_class,
*(loc:@gradients/loss/sub_1_grad/Reshape_1*
T0*#
_output_shapes
:џџџџџџџџџ
e
gradients/loss/Sum_grad/ShapeShapeloss/mul*
T0*
out_type0*
_output_shapes
:
^
gradients/loss/Sum_grad/SizeConst*
value	B :*
dtype0*
_output_shapes
: 
}
gradients/loss/Sum_grad/addAddloss/Sum/reduction_indicesgradients/loss/Sum_grad/Size*
T0*
_output_shapes
: 

gradients/loss/Sum_grad/modFloorModgradients/loss/Sum_grad/addgradients/loss/Sum_grad/Size*
T0*
_output_shapes
: 
b
gradients/loss/Sum_grad/Shape_1Const*
valueB *
dtype0*
_output_shapes
: 
e
#gradients/loss/Sum_grad/range/startConst*
value	B : *
dtype0*
_output_shapes
: 
e
#gradients/loss/Sum_grad/range/deltaConst*
value	B :*
dtype0*
_output_shapes
: 
Ж
gradients/loss/Sum_grad/rangeRange#gradients/loss/Sum_grad/range/startgradients/loss/Sum_grad/Size#gradients/loss/Sum_grad/range/delta*

Tidx0*
_output_shapes
:
d
"gradients/loss/Sum_grad/Fill/valueConst*
value	B :*
dtype0*
_output_shapes
: 

gradients/loss/Sum_grad/FillFillgradients/loss/Sum_grad/Shape_1"gradients/loss/Sum_grad/Fill/value*
T0*
_output_shapes
: 
ц
%gradients/loss/Sum_grad/DynamicStitchDynamicStitchgradients/loss/Sum_grad/rangegradients/loss/Sum_grad/modgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Fill*
N*
T0*#
_output_shapes
:џџџџџџџџџ
c
!gradients/loss/Sum_grad/Maximum/yConst*
value	B :*
dtype0*
_output_shapes
: 
Ђ
gradients/loss/Sum_grad/MaximumMaximum%gradients/loss/Sum_grad/DynamicStitch!gradients/loss/Sum_grad/Maximum/y*
T0*#
_output_shapes
:џџџџџџџџџ

 gradients/loss/Sum_grad/floordivFloorDivgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Maximum*
T0*
_output_shapes
:
Ж
gradients/loss/Sum_grad/ReshapeReshape2gradients/loss/add_grad/tuple/control_dependency_1%gradients/loss/Sum_grad/DynamicStitch*
T0*
Tshape0*
_output_shapes
:
Ћ
gradients/loss/Sum_grad/TileTilegradients/loss/Sum_grad/Reshape gradients/loss/Sum_grad/floordiv*
T0*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ

ы
gradients/AddNAddN2gradients/loss/pow_2_grad/tuple/control_dependency2gradients/loss/sub_1_grad/tuple/control_dependency*
N*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ

'gradients/loss/pos_item_bias_grad/ShapeConst*&
_class
loc:@variables/item_bias*
valueB:э*
dtype0*
_output_shapes
:

&gradients/loss/pos_item_bias_grad/SizeSizeplaceholders/sampled_pos_items*
T0*
out_type0*
_output_shapes
: 
r
0gradients/loss/pos_item_bias_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
Х
,gradients/loss/pos_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/pos_item_bias_grad/Size0gradients/loss/pos_item_bias_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:

5gradients/loss/pos_item_bias_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:

7gradients/loss/pos_item_bias_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:

7gradients/loss/pos_item_bias_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
Ѕ
/gradients/loss/pos_item_bias_grad/strided_sliceStridedSlice'gradients/loss/pos_item_bias_grad/Shape5gradients/loss/pos_item_bias_grad/strided_slice/stack7gradients/loss/pos_item_bias_grad/strided_slice/stack_17gradients/loss/pos_item_bias_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
: *
end_mask*

begin_mask 
o
-gradients/loss/pos_item_bias_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ќ
(gradients/loss/pos_item_bias_grad/concatConcatV2,gradients/loss/pos_item_bias_grad/ExpandDims/gradients/loss/pos_item_bias_grad/strided_slice-gradients/loss/pos_item_bias_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Њ
)gradients/loss/pos_item_bias_grad/ReshapeReshapegradients/AddN(gradients/loss/pos_item_bias_grad/concat*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
Р
+gradients/loss/pos_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_pos_items,gradients/loss/pos_item_bias_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
я
gradients/AddN_1AddN2gradients/loss/pow_4_grad/tuple/control_dependency4gradients/loss/sub_1_grad/tuple/control_dependency_1*
N*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape*
T0*#
_output_shapes
:џџџџџџџџџ

'gradients/loss/neg_item_bias_grad/ShapeConst*&
_class
loc:@variables/item_bias*
valueB:э*
dtype0*
_output_shapes
:

&gradients/loss/neg_item_bias_grad/SizeSizeplaceholders/sampled_neg_items*
T0*
out_type0*
_output_shapes
: 
r
0gradients/loss/neg_item_bias_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
Х
,gradients/loss/neg_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/neg_item_bias_grad/Size0gradients/loss/neg_item_bias_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:

5gradients/loss/neg_item_bias_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:

7gradients/loss/neg_item_bias_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:

7gradients/loss/neg_item_bias_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
Ѕ
/gradients/loss/neg_item_bias_grad/strided_sliceStridedSlice'gradients/loss/neg_item_bias_grad/Shape5gradients/loss/neg_item_bias_grad/strided_slice/stack7gradients/loss/neg_item_bias_grad/strided_slice/stack_17gradients/loss/neg_item_bias_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
: *
end_mask*

begin_mask 
o
-gradients/loss/neg_item_bias_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ќ
(gradients/loss/neg_item_bias_grad/concatConcatV2,gradients/loss/neg_item_bias_grad/ExpandDims/gradients/loss/neg_item_bias_grad/strided_slice-gradients/loss/neg_item_bias_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Ќ
)gradients/loss/neg_item_bias_grad/ReshapeReshapegradients/AddN_1(gradients/loss/neg_item_bias_grad/concat*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
Р
+gradients/loss/neg_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_neg_items,gradients/loss/neg_item_bias_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
g
gradients/loss/mul_grad/ShapeShape
loss/users*
T0*
out_type0*
_output_shapes
:
g
gradients/loss/mul_grad/Shape_1Shapeloss/sub*
T0*
out_type0*
_output_shapes
:
У
-gradients/loss/mul_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_grad/Shapegradients/loss/mul_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
|
gradients/loss/mul_grad/mulMulgradients/loss/Sum_grad/Tileloss/sub*
T0*'
_output_shapes
:џџџџџџџџџ

Ў
gradients/loss/mul_grad/SumSumgradients/loss/mul_grad/mul-gradients/loss/mul_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
І
gradients/loss/mul_grad/ReshapeReshapegradients/loss/mul_grad/Sumgradients/loss/mul_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/mul_grad/mul_1Mul
loss/usersgradients/loss/Sum_grad/Tile*
T0*'
_output_shapes
:џџџџџџџџџ

Д
gradients/loss/mul_grad/Sum_1Sumgradients/loss/mul_grad/mul_1/gradients/loss/mul_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
Ќ
!gradients/loss/mul_grad/Reshape_1Reshapegradients/loss/mul_grad/Sum_1gradients/loss/mul_grad/Shape_1*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

v
(gradients/loss/mul_grad/tuple/group_depsNoOp ^gradients/loss/mul_grad/Reshape"^gradients/loss/mul_grad/Reshape_1
ю
0gradients/loss/mul_grad/tuple/control_dependencyIdentitygradients/loss/mul_grad/Reshape)^gradients/loss/mul_grad/tuple/group_deps*2
_class(
&$loc:@gradients/loss/mul_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

є
2gradients/loss/mul_grad/tuple/control_dependency_1Identity!gradients/loss/mul_grad/Reshape_1)^gradients/loss/mul_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/mul_grad/Reshape_1*
T0*'
_output_shapes
:џџџџџџџџџ

W
gradients/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
Ь
gradients/concatConcatV2)gradients/loss/pos_item_bias_grad/Reshape)gradients/loss/neg_item_bias_grad/Reshapegradients/concat/axis*
N*

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
Y
gradients/concat_1/axisConst*
value	B : *
dtype0*
_output_shapes
: 
д
gradients/concat_1ConcatV2+gradients/loss/pos_item_bias_grad/Reshape_1+gradients/loss/neg_item_bias_grad/Reshape_1gradients/concat_1/axis*
N*

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
ы
gradients/AddN_2AddN0gradients/loss/pow_grad/tuple/control_dependency0gradients/loss/mul_grad/tuple/control_dependency*
N*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ


gradients/loss/users_grad/ShapeConst*)
_class
loc:@variables/user_factors*
valueB"  
   *
dtype0*
_output_shapes
:
s
gradients/loss/users_grad/SizeSizeplaceholders/sampled_users*
T0*
out_type0*
_output_shapes
: 
j
(gradients/loss/users_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
­
$gradients/loss/users_grad/ExpandDims
ExpandDimsgradients/loss/users_grad/Size(gradients/loss/users_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:
w
-gradients/loss/users_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:
y
/gradients/loss/users_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:
y
/gradients/loss/users_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:
џ
'gradients/loss/users_grad/strided_sliceStridedSlicegradients/loss/users_grad/Shape-gradients/loss/users_grad/strided_slice/stack/gradients/loss/users_grad/strided_slice/stack_1/gradients/loss/users_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
:*
end_mask*

begin_mask 
g
%gradients/loss/users_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
м
 gradients/loss/users_grad/concatConcatV2$gradients/loss/users_grad/ExpandDims'gradients/loss/users_grad/strided_slice%gradients/loss/users_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Љ
!gradients/loss/users_grad/ReshapeReshapegradients/AddN_2 gradients/loss/users_grad/concat*
T0*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Ќ
#gradients/loss/users_grad/Reshape_1Reshapeplaceholders/sampled_users$gradients/loss/users_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
k
gradients/loss/sub_grad/ShapeShapeloss/pos_items*
T0*
out_type0*
_output_shapes
:
m
gradients/loss/sub_grad/Shape_1Shapeloss/neg_items*
T0*
out_type0*
_output_shapes
:
У
-gradients/loss/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_grad/Shapegradients/loss/sub_grad/Shape_1*
T0*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ
Х
gradients/loss/sub_grad/SumSum2gradients/loss/mul_grad/tuple/control_dependency_1-gradients/loss/sub_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
І
gradients/loss/sub_grad/ReshapeReshapegradients/loss/sub_grad/Sumgradients/loss/sub_grad/Shape*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

Щ
gradients/loss/sub_grad/Sum_1Sum2gradients/loss/mul_grad/tuple/control_dependency_1/gradients/loss/sub_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
T0*
_output_shapes
:
d
gradients/loss/sub_grad/NegNeggradients/loss/sub_grad/Sum_1*
T0*
_output_shapes
:
Њ
!gradients/loss/sub_grad/Reshape_1Reshapegradients/loss/sub_grad/Neggradients/loss/sub_grad/Shape_1*
T0*
Tshape0*'
_output_shapes
:џџџџџџџџџ

v
(gradients/loss/sub_grad/tuple/group_depsNoOp ^gradients/loss/sub_grad/Reshape"^gradients/loss/sub_grad/Reshape_1
ю
0gradients/loss/sub_grad/tuple/control_dependencyIdentitygradients/loss/sub_grad/Reshape)^gradients/loss/sub_grad/tuple/group_deps*2
_class(
&$loc:@gradients/loss/sub_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ

є
2gradients/loss/sub_grad/tuple/control_dependency_1Identity!gradients/loss/sub_grad/Reshape_1)^gradients/loss/sub_grad/tuple/group_deps*4
_class*
(&loc:@gradients/loss/sub_grad/Reshape_1*
T0*'
_output_shapes
:џџџџџџџџџ

я
gradients/AddN_3AddN2gradients/loss/pow_1_grad/tuple/control_dependency0gradients/loss/sub_grad/tuple/control_dependency*
N*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ


#gradients/loss/pos_items_grad/ShapeConst*)
_class
loc:@variables/item_factors*
valueB"m  
   *
dtype0*
_output_shapes
:
{
"gradients/loss/pos_items_grad/SizeSizeplaceholders/sampled_pos_items*
T0*
out_type0*
_output_shapes
: 
n
,gradients/loss/pos_items_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
Й
(gradients/loss/pos_items_grad/ExpandDims
ExpandDims"gradients/loss/pos_items_grad/Size,gradients/loss/pos_items_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:
{
1gradients/loss/pos_items_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:
}
3gradients/loss/pos_items_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:
}
3gradients/loss/pos_items_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:

+gradients/loss/pos_items_grad/strided_sliceStridedSlice#gradients/loss/pos_items_grad/Shape1gradients/loss/pos_items_grad/strided_slice/stack3gradients/loss/pos_items_grad/strided_slice/stack_13gradients/loss/pos_items_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
:*
end_mask*

begin_mask 
k
)gradients/loss/pos_items_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ь
$gradients/loss/pos_items_grad/concatConcatV2(gradients/loss/pos_items_grad/ExpandDims+gradients/loss/pos_items_grad/strided_slice)gradients/loss/pos_items_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Б
%gradients/loss/pos_items_grad/ReshapeReshapegradients/AddN_3$gradients/loss/pos_items_grad/concat*
T0*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
И
'gradients/loss/pos_items_grad/Reshape_1Reshapeplaceholders/sampled_pos_items(gradients/loss/pos_items_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
ё
gradients/AddN_4AddN2gradients/loss/pow_3_grad/tuple/control_dependency2gradients/loss/sub_grad/tuple/control_dependency_1*
N*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape*
T0*'
_output_shapes
:џџџџџџџџџ


#gradients/loss/neg_items_grad/ShapeConst*)
_class
loc:@variables/item_factors*
valueB"m  
   *
dtype0*
_output_shapes
:
{
"gradients/loss/neg_items_grad/SizeSizeplaceholders/sampled_neg_items*
T0*
out_type0*
_output_shapes
: 
n
,gradients/loss/neg_items_grad/ExpandDims/dimConst*
value	B : *
dtype0*
_output_shapes
: 
Й
(gradients/loss/neg_items_grad/ExpandDims
ExpandDims"gradients/loss/neg_items_grad/Size,gradients/loss/neg_items_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:
{
1gradients/loss/neg_items_grad/strided_slice/stackConst*
valueB:*
dtype0*
_output_shapes
:
}
3gradients/loss/neg_items_grad/strided_slice/stack_1Const*
valueB: *
dtype0*
_output_shapes
:
}
3gradients/loss/neg_items_grad/strided_slice/stack_2Const*
valueB:*
dtype0*
_output_shapes
:

+gradients/loss/neg_items_grad/strided_sliceStridedSlice#gradients/loss/neg_items_grad/Shape1gradients/loss/neg_items_grad/strided_slice/stack3gradients/loss/neg_items_grad/strided_slice/stack_13gradients/loss/neg_items_grad/strided_slice/stack_2*
shrink_axis_mask *
new_axis_mask *
Index0*
ellipsis_mask *
T0*
_output_shapes
:*
end_mask*

begin_mask 
k
)gradients/loss/neg_items_grad/concat/axisConst*
value	B : *
dtype0*
_output_shapes
: 
ь
$gradients/loss/neg_items_grad/concatConcatV2(gradients/loss/neg_items_grad/ExpandDims+gradients/loss/neg_items_grad/strided_slice)gradients/loss/neg_items_grad/concat/axis*
N*

Tidx0*
T0*
_output_shapes
:
Б
%gradients/loss/neg_items_grad/ReshapeReshapegradients/AddN_4$gradients/loss/neg_items_grad/concat*
T0*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
И
'gradients/loss/neg_items_grad/Reshape_1Reshapeplaceholders/sampled_neg_items(gradients/loss/neg_items_grad/ExpandDims*
T0*
Tshape0*#
_output_shapes
:џџџџџџџџџ
Y
gradients/concat_2/axisConst*
value	B : *
dtype0*
_output_shapes
: 
е
gradients/concat_2ConcatV2%gradients/loss/pos_items_grad/Reshape%gradients/loss/neg_items_grad/Reshapegradients/concat_2/axis*
N*

Tidx0*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Y
gradients/concat_3/axisConst*
value	B : *
dtype0*
_output_shapes
: 
Ь
gradients/concat_3ConcatV2'gradients/loss/pos_items_grad/Reshape_1'gradients/loss/neg_items_grad/Reshape_1gradients/concat_3/axis*
N*

Tidx0*
T0*#
_output_shapes
:џџџџџџџџџ
b
GradientDescent/learning_rateConst*
valueB
 *ЭЬЬ=*
dtype0*
_output_shapes
: 
р
1GradientDescent/update_variables/user_factors/mulMul!gradients/loss/users_grad/ReshapeGradientDescent/learning_rate*)
_class
loc:@variables/user_factors*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ
Ў
8GradientDescent/update_variables/user_factors/ScatterSub
ScatterSubvariables/user_factors#gradients/loss/users_grad/Reshape_11GradientDescent/update_variables/user_factors/mul*
Tindices0*
use_locking( *
T0*)
_class
loc:@variables/user_factors*
_output_shapes
:	

б
1GradientDescent/update_variables/item_factors/mulMulgradients/concat_2GradientDescent/learning_rate*)
_class
loc:@variables/item_factors*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ

8GradientDescent/update_variables/item_factors/ScatterSub
ScatterSubvariables/item_factorsgradients/concat_31GradientDescent/update_variables/item_factors/mul*
Tindices0*
use_locking( *
T0*)
_class
loc:@variables/item_factors*
_output_shapes
:	э

М
.GradientDescent/update_variables/item_bias/mulMulgradients/concatGradientDescent/learning_rate*&
_class
loc:@variables/item_bias*
T0*#
_output_shapes
:џџџџџџџџџ

5GradientDescent/update_variables/item_bias/ScatterSub
ScatterSubvariables/item_biasgradients/concat_1.GradientDescent/update_variables/item_bias/mul*
Tindices0*
use_locking( *
T0*&
_class
loc:@variables/item_bias*
_output_shapes	
:э
Х
GradientDescentNoOp9^GradientDescent/update_variables/user_factors/ScatterSub9^GradientDescent/update_variables/item_factors/ScatterSub6^GradientDescent/update_variables/item_bias/ScatterSub
R
loss_1/tagsConst*
valueB Bloss_1*
dtype0*
_output_shapes
: 
Q
loss_1ScalarSummaryloss_1/tags
loss/sub_2*
T0*
_output_shapes
: 
K
Merge/MergeSummaryMergeSummaryloss_1*
N*
_output_shapes
: 
i
initNoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign""
train_op

GradientDescent"
	summaries


loss_1:0"
	variables
X
variables/user_factors:0variables/user_factors/Assignvariables/user_factors/read:0
X
variables/item_factors:0variables/item_factors/Assignvariables/item_factors/read:0
O
variables/item_bias:0variables/item_bias/Assignvariables/item_bias/read:0" 
trainable_variables
X
variables/user_factors:0variables/user_factors/Assignvariables/user_factors/read:0
X
variables/item_factors:0variables/item_factors/Assignvariables/item_factors/read:0
O
variables/item_bias:0variables/item_bias/Assignvariables/item_bias/read:05i        и-	0щ^жA*

loss_1CеИ       ШС	m1щ^жA*

loss_1,нCG!'У       ШС	ОL2щ^жA*

loss_1WCќu       ШС	/3щ^жA*

loss_1Ш&CЧmш       ШС	Г4щ^жA*

loss_14ѕCѕжСЈ       ШС	-в4щ^жA*

loss_1Щ6CWr3У       ШС	Џ5щ^жA*

loss_1C_V       ШС	Є6щ^жA*

loss_1Cg7O       ШС	Йn7щ^жA*

loss_1oЭCёй;       ШС	б\8щ^жA	*

loss_1вCblцВ       ШС	)B9щ^жA
*

loss_1^)C7Ж#       ШС	,:щ^жA*

loss_1ЉC#+X       ШС	wѕ:щ^жA*

loss_1ЮТCЖТ       ШС	GЦ;щ^жA*

loss_1Ф	CЪш$       ШС	vЇ<щ^жA*

loss_1sC>Щ       ШС	=щ^жA*

loss_1/дCk5Б       ШС	G>щ^жA*

loss_1rCЬЛцi       ШС	к<?щ^жA*

loss_1`CЫfіэ       ШС	@щ^жA*

loss_1џCN5$Г       ШС	Эш@щ^жA*

loss_1OћBљфЧ       ШС	ђэAщ^жA*

loss_1x Cа\Р       ШС	яBщ^жA*

loss_1PИCyЬВў       ШС	_ЮCщ^жA*

loss_1УяCtTЫ       ШС	хDщ^жA*

loss_1EЇCЇБ{       ШС	ЦnEщ^жA*

loss_1Аv CJ2Ц       ШС	ђaFщ^жA*

loss_1ѕCYЊa       ШС	.:Gщ^жA*

loss_1CdќB&       ШС	Џ	Hщ^жA*

loss_1	 CфН/       ШС	єсHщ^жA*

loss_1ПФCъE{       ШС	МIщ^жA*

loss_1эљBdЕЕ       ШС	ћАJщ^жA*

loss_1юoCвdд       ШС	UЃKщ^жA*

loss_1	Cў       ШС	Р{Lщ^жA *

loss_1ќB*}Ой       ШС	 lMщ^жA!*

loss_1(vњBЯ8УЦ       ШС	ѓ;Nщ^жA"*

loss_1?їB.Qkй       ШС	4Oщ^жA#*

loss_1ќBеЮe       ШС	r§Oщ^жA$*

loss_1ЗўBVћ.       ШС	RвPщ^жA%*

loss_1їШѕBRТu       ШС	 Qщ^жA&*

loss_1\*їB{љLЧ       ШС	а}Rщ^жA'*

loss_1ўBий5       ШС	IdSщ^жA(*

loss_1ЅёBЗЉЃ       ШС	bITщ^жA)*

loss_1яB(BY       ШС	Uщ^жA**

loss_1=ѕBrтр       ШС	JVщ^жA+*

loss_1къюBЇэ       ШС	pяVщ^жA,*

loss_1ТчщBЦхЊ       ШС	SГWщ^жA-*

loss_1!юBwСм       ШС	uXщ^жA.*

loss_1:аёBxt~G       ШС	hvYщ^жA/*

loss_16іыBJ^       ШС	2YZщ^жA0*

loss_1І/ъBЌdP'       ШС	1D[щ^жA1*

loss_1єWэB|S       ШС	­/\щ^жA2*

loss_1Є?ьBhN:       ШС	й]щ^жA3*

loss_1iхBтх       ШС	г]щ^жA4*

loss_1=\ьBa;gп       ШС	Ј^щ^жA5*

loss_1ЯыBe8       ШС	_щ^жA6*

loss_1llоBПј       ШС	D`щ^жA7*

loss_1ІжмB"хИS       ШС	'faщ^жA8*

loss_1rїчBЈcM       ШС	mbщ^жA9*

loss_1YткBU0       ШС	cщ^жA:*

loss_14пB$Зf       ШС	3odщ^жA;*

loss_1ХхB~4       ШС	љNeщ^жA<*

loss_1щЊкBЎ^       ШС	@fщ^жA=*

loss_1/ійBD НM       ШС	4,gщ^жA>*

loss_1\иBLџ       ШС	Ahщ^жA?*

loss_1
(ЯBtБ       ШС	дiщ^жA@*

loss_1кBЯl"з       ШС	Ojщ^жAA*

loss_1IжB))       ШС	>чjщ^жAB*

loss_1њаB]Н$       ШС	Эkщ^жAC*

loss_1бзBЄfky       ШС	Иlщ^жAD*

loss_1іљбB4f       ШС	щmщ^жAE*

loss_1JЬBОЉC       ШС	:tnщ^жAF*

loss_1+CЩBWкp       ШС	Ёgoщ^жAG*

loss_1ћУBЮє       ШС	-_pщ^жAH*

loss_1ЫBЄиЅL       ШС	р*qщ^жAI*

loss_1жkЮBиZ       ШС	Эrщ^жAJ*

loss_126ЧB2d!S       ШС	ццrщ^жAK*

loss_1Ы8РBМH9       ШС	Ьsщ^жAL*

loss_1єПBчиЫZ       ШС	Q tщ^жAM*

loss_1ЉЖBБ[n       ШС	ъzuщ^жAN*

loss_1b6РBњЛп       ШС	вvщ^жAO*

loss_1ЫBzњ(       ШС	тuwщ^жAP*

loss_13QЖBЏІW       ШС	-`xщ^жAQ*

loss_1рЧBлS       ШС	ѕIyщ^жAR*

loss_1ьКB Хw5       ШС	+zщ^жAS*

loss_1$ќОBrхЎј       ШС	јzщ^жAT*

loss_1
ПBНu}       ШС	oж{щ^жAU*

loss_1o.ГB%Cм       ШС	ЗЕ|щ^жAV*

loss_1k}ЕBXдn       ШС	Р}щ^жAW*

loss_1ZЎBыѓ>>       ШС	тv~щ^жAX*

loss_1hАБB+[       ШС	5]щ^жAY*

loss_1VуЖBЪ-г       ШС	*8щ^жAZ*

loss_12ПЉBЪ,i       ШС	щ^жA[*

loss_1НFВBЇ{       ШС	Kхщ^жA\*

loss_1gFBmАЎ       ШС	`шщ^жA]*

loss_1ѓЊBгћї       ШС	lащ^жA^*

loss_1}BЧ?ћт       ШС	гМщ^жA_*

loss_1 КЂBиil       ШС	lБщ^жA`*

loss_1ЁB,зА       ШС	БІщ^жAa*

loss_1HЊBHaшГ       ШС	]Ѕщ^жAb*

loss_1ЋЇByчoE       ШС	эщ^жAc*

loss_1цTЂB8И9       ШС	Ащ^жAd*

loss_1 ЋBmn\ћ       ШС	~щ^жAe*

loss_1АЃBLЇУѓ       ШС	XSщ^жAf*

loss_1цЄЈBZт>Ы       ШС	O=щ^жAg*

loss_1ЧBГМФN       ШС	U2щ^жAh*

loss_1BDW       ШС	[&щ^жAi*

loss_1ЩBЧСhЕ       ШС	щ^жAj*

loss_1OЎBЄd       ШС	Аўщ^жAk*

loss_1fу BCй6І       ШС	Олщ^жAl*

loss_1пёBЛc5ж       ШС	?­щ^жAm*

loss_1ZBn?Ћ       ШС	+щ^жAn*

loss_11пBЩЏб       ШС	З_щ^жAo*

loss_1ЯрЁBѕ\ѕr       ШС	0Lщ^жAp*

loss_1МЁBњfъP       ШС	цщ^жAq*

loss_1_ЇB/ЕЎj       ШС	
єщ^жAr*

loss_1дтBЖЪф       ШС	їЫщ^жAs*

loss_1ЋBЂ8Ш       ШС	5Зщ^жAt*

loss_1CЏBWрЫ       ШС	Ђщ^жAu*

loss_1/lЅBийЃx       ШС	mrщ^жAv*

loss_1ШРBы1.       ШС	Vщ^жAw*

loss_1ъUBйХ       ШС	|Cщ^жAx*

loss_1*5BсщЉ       ШС	@0щ^жAy*

loss_1GBSжЄ       ШС	щ^жAz*

loss_1аЈBI       ШС	Ь№щ^жA{*

loss_1ёWBсЎ6/       ШС	+ощ^жA|*

loss_1;ЂBKР?       ШС	KЫщ^жA}*

loss_1wsB1gT       ШС	ЩЊ щ^жA~*

loss_1%B&/к       ШС	PqЁщ^жA*

loss_1љBbZБ       `/п#	бWЂщ^жA*

loss_1ХBCТu       `/п#	Ї?Ѓщ^жA*

loss_1жKBlЃTш       `/п#	UЄщ^жA*

loss_1SчB~T        `/п#	упЄщ^жA*

loss_1"КBSVў       `/п#	DПЅщ^жA*

loss_1ЋBцЩЋ^       `/п#	ѕЂІщ^жA*

loss_1%.BьИ0Y       `/п#	уpЇщ^жA*

loss_1э>B7F       `/п#	я8Јщ^жA*

loss_1ЙщBоѓмK       `/п#	Д!Љщ^жA*

loss_1U:BРЅ       `/п#	а	Њщ^жA*

loss_1ўBУЬ       `/п#	OЯЊщ^жA*

loss_1ы{Bв+%       `/п#	ЦЄЋщ^жA*

loss_1Bx5у       `/п#	­Ќщ^жA*

loss_1B]ЌЙS       `/п#	l­щ^жA*

loss_1cэBЎTНщ       `/п#	BЎщ^жA*

loss_1b#BК]DЎ       `/п#	(Џщ^жA*

loss_1P"BчЗ       `/п#	є5Ащ^жA*

loss_1ЪЗ|BеEеW       `/п#	` Бщ^жA*

loss_1ѕfB]NmV       `/п#	uВщ^жA*

loss_1zB(HA       `/п#	lшВщ^жA*

loss_1nBz4#S       `/п#	щвГщ^жA*

loss_1.nBж#+7       `/п#	KЋДщ^жA*

loss_1mBGUГ