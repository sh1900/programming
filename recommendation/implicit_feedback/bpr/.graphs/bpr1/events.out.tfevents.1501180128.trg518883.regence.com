       ЃK"	   8^жAbrain.Event:2іr=ќ       Kp	+і7^жA"ѓЇ
h
placeholders/sampled_usersPlaceholder*
shape: *#
_output_shapes
:џџџџџџџџџ*
dtype0
l
placeholders/sampled_pos_itemsPlaceholder*
shape: *#
_output_shapes
:џџџџџџџџџ*
dtype0
l
placeholders/sampled_neg_itemsPlaceholder*
shape: *#
_output_shapes
:џџџџџџџџџ*
dtype0
q
 variables/truncated_normal/shapeConst*
valueB"  
   *
_output_shapes
:*
dtype0
d
variables/truncated_normal/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
f
!variables/truncated_normal/stddevConst*
valueB
 *шЁ>*
_output_shapes
: *
dtype0
Г
*variables/truncated_normal/TruncatedNormalTruncatedNormal variables/truncated_normal/shape*
seed2в	*
dtype0*
_output_shapes
:	
*
seedБџх)*
T0

variables/truncated_normal/mulMul*variables/truncated_normal/TruncatedNormal!variables/truncated_normal/stddev*
_output_shapes
:	
*
T0

variables/truncated_normalAddvariables/truncated_normal/mulvariables/truncated_normal/mean*
_output_shapes
:	
*
T0
s
"variables/truncated_normal_1/shapeConst*
valueB"m  
   *
_output_shapes
:*
dtype0
f
!variables/truncated_normal_1/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
h
#variables/truncated_normal_1/stddevConst*
valueB
 *шЁ>*
_output_shapes
: *
dtype0
З
,variables/truncated_normal_1/TruncatedNormalTruncatedNormal"variables/truncated_normal_1/shape*
seed2в	*
dtype0*
_output_shapes
:	э
*
seedБџх)*
T0
Є
 variables/truncated_normal_1/mulMul,variables/truncated_normal_1/TruncatedNormal#variables/truncated_normal_1/stddev*
_output_shapes
:	э
*
T0

variables/truncated_normal_1Add variables/truncated_normal_1/mul!variables/truncated_normal_1/mean*
_output_shapes
:	э
*
T0

variables/user_factors
VariableV2*
shape:	
*
shared_name *
_output_shapes
:	
*
	container *
dtype0
й
variables/user_factors/AssignAssignvariables/user_factorsvariables/truncated_normal*
use_locking(*
validate_shape(*
_output_shapes
:	
*)
_class
loc:@variables/user_factors*
T0

variables/user_factors/readIdentityvariables/user_factors*
_output_shapes
:	
*)
_class
loc:@variables/user_factors*
T0

variables/item_factors
VariableV2*
shape:	э
*
shared_name *
_output_shapes
:	э
*
	container *
dtype0
л
variables/item_factors/AssignAssignvariables/item_factorsvariables/truncated_normal_1*
use_locking(*
validate_shape(*
_output_shapes
:	э
*)
_class
loc:@variables/item_factors*
T0

variables/item_factors/readIdentityvariables/item_factors*
_output_shapes
:	э
*)
_class
loc:@variables/item_factors*
T0
^
variables/zerosConst*
valueBэ*    *
_output_shapes	
:э*
dtype0

variables/item_bias
VariableV2*
shape:э*
shared_name *
_output_shapes	
:э*
	container *
dtype0
С
variables/item_bias/AssignAssignvariables/item_biasvariables/zeros*
use_locking(*
validate_shape(*
_output_shapes	
:э*&
_class
loc:@variables/item_bias*
T0

variables/item_bias/readIdentityvariables/item_bias*
_output_shapes	
:э*&
_class
loc:@variables/item_bias*
T0
­

loss/usersGathervariables/user_factors/readplaceholders/sampled_users*
Tparams0*'
_output_shapes
:џџџџџџџџџ
*
validate_indices(*
Tindices0
Е
loss/pos_itemsGathervariables/item_factors/readplaceholders/sampled_pos_items*
Tparams0*'
_output_shapes
:џџџџџџџџџ
*
validate_indices(*
Tindices0
Е
loss/neg_itemsGathervariables/item_factors/readplaceholders/sampled_neg_items*
Tparams0*'
_output_shapes
:џџџџџџџџџ
*
validate_indices(*
Tindices0
В
loss/pos_item_biasGathervariables/item_bias/readplaceholders/sampled_pos_items*
Tparams0*#
_output_shapes
:џџџџџџџџџ*
validate_indices(*
Tindices0
В
loss/neg_item_biasGathervariables/item_bias/readplaceholders/sampled_neg_items*
Tparams0*#
_output_shapes
:џџџџџџџџџ*
validate_indices(*
Tindices0
a
loss/subSubloss/pos_itemsloss/neg_items*'
_output_shapes
:џџџџџџџџџ
*
T0
W
loss/mulMul
loss/usersloss/sub*'
_output_shapes
:џџџџџџџџџ
*
T0
\
loss/Sum/reduction_indicesConst*
value	B :*
_output_shapes
: *
dtype0

loss/SumSumloss/mulloss/Sum/reduction_indices*
	keep_dims( *
T0*#
_output_shapes
:џџџџџџџџџ*

Tidx0
g

loss/sub_1Subloss/pos_item_biasloss/neg_item_bias*#
_output_shapes
:џџџџџџџџџ*
T0
S
loss/addAdd
loss/sub_1loss/Sum*#
_output_shapes
:џџџџџџџџџ*
T0
G
loss/NegNegloss/add*#
_output_shapes
:џџџџџџџџџ*
T0
G
loss/ExpExploss/Neg*#
_output_shapes
:џџџџџџџџџ*
T0
Q
loss/add_1/xConst*
valueB
 *  ?*
_output_shapes
: *
dtype0
W

loss/add_1Addloss/add_1/xloss/Exp*#
_output_shapes
:џџџџџџџџџ*
T0
I
loss/LogLog
loss/add_1*#
_output_shapes
:џџџџџџџџџ*
T0
I

loss/Neg_1Negloss/Log*#
_output_shapes
:џџџџџџџџџ*
T0
T

loss/ConstConst*
valueB: *
_output_shapes
:*
dtype0
g

loss/Sum_1Sum
loss/Neg_1
loss/Const*
	keep_dims( *
T0*
_output_shapes
: *

Tidx0
O

loss/pow/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
Y
loss/powPow
loss/users
loss/pow/y*'
_output_shapes
:џџџџџџџџџ
*
T0
]
loss/Const_1Const*
valueB"       *
_output_shapes
:*
dtype0
g

loss/Sum_2Sumloss/powloss/Const_1*
	keep_dims( *
T0*
_output_shapes
: *

Tidx0
Q
loss/mul_1/xConst*
valueB
 *
з#<*
_output_shapes
: *
dtype0
L

loss/mul_1Mulloss/mul_1/x
loss/Sum_2*
_output_shapes
: *
T0
Q
loss/pow_1/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
a

loss/pow_1Powloss/pos_itemsloss/pow_1/y*'
_output_shapes
:џџџџџџџџџ
*
T0
]
loss/Const_2Const*
valueB"       *
_output_shapes
:*
dtype0
i

loss/Sum_3Sum
loss/pow_1loss/Const_2*
	keep_dims( *
T0*
_output_shapes
: *

Tidx0
Q
loss/mul_2/xConst*
valueB
 *
з#<*
_output_shapes
: *
dtype0
L

loss/mul_2Mulloss/mul_2/x
loss/Sum_3*
_output_shapes
: *
T0
Q
loss/pow_2/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
a

loss/pow_2Powloss/pos_item_biasloss/pow_2/y*#
_output_shapes
:џџџџџџџџџ*
T0
V
loss/Const_3Const*
valueB: *
_output_shapes
:*
dtype0
i

loss/Sum_4Sum
loss/pow_2loss/Const_3*
	keep_dims( *
T0*
_output_shapes
: *

Tidx0
J

loss/add_2Add
loss/mul_2
loss/Sum_4*
_output_shapes
: *
T0
Q
loss/pow_3/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
a

loss/pow_3Powloss/neg_itemsloss/pow_3/y*'
_output_shapes
:џџџџџџџџџ
*
T0
]
loss/Const_4Const*
valueB"       *
_output_shapes
:*
dtype0
i

loss/Sum_5Sum
loss/pow_3loss/Const_4*
	keep_dims( *
T0*
_output_shapes
: *

Tidx0
Q
loss/mul_3/xConst*
valueB
 *
з#<*
_output_shapes
: *
dtype0
L

loss/mul_3Mulloss/mul_3/x
loss/Sum_5*
_output_shapes
: *
T0
Q
loss/pow_4/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
a

loss/pow_4Powloss/neg_item_biasloss/pow_4/y*#
_output_shapes
:џџџџџџџџџ*
T0
V
loss/Const_5Const*
valueB: *
_output_shapes
:*
dtype0
i

loss/Sum_6Sum
loss/pow_4loss/Const_5*
	keep_dims( *
T0*
_output_shapes
: *

Tidx0
J

loss/add_3Add
loss/mul_3
loss/Sum_6*
_output_shapes
: *
T0
J

loss/add_4Add
loss/mul_1
loss/add_2*
_output_shapes
: *
T0
J

loss/add_5Add
loss/add_4
loss/add_3*
_output_shapes
: *
T0
J

loss/sub_2Sub
loss/add_5
loss/Sum_1*
_output_shapes
: *
T0
R
gradients/ShapeConst*
valueB *
_output_shapes
: *
dtype0
T
gradients/ConstConst*
valueB
 *  ?*
_output_shapes
: *
dtype0
Y
gradients/FillFillgradients/Shapegradients/Const*
_output_shapes
: *
T0
b
gradients/loss/sub_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/sub_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_2_grad/Shape!gradients/loss/sub_2_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Ѕ
gradients/loss/sub_2_grad/SumSumgradients/Fill/gradients/loss/sub_2_grad/BroadcastGradientArgs*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0

!gradients/loss/sub_2_grad/ReshapeReshapegradients/loss/sub_2_grad/Sumgradients/loss/sub_2_grad/Shape*
Tshape0*
_output_shapes
: *
T0
Љ
gradients/loss/sub_2_grad/Sum_1Sumgradients/Fill1gradients/loss/sub_2_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
h
gradients/loss/sub_2_grad/NegNeggradients/loss/sub_2_grad/Sum_1*
_output_shapes
:*
T0

#gradients/loss/sub_2_grad/Reshape_1Reshapegradients/loss/sub_2_grad/Neg!gradients/loss/sub_2_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/sub_2_grad/tuple/group_depsNoOp"^gradients/loss/sub_2_grad/Reshape$^gradients/loss/sub_2_grad/Reshape_1
х
2gradients/loss/sub_2_grad/tuple/control_dependencyIdentity!gradients/loss/sub_2_grad/Reshape+^gradients/loss/sub_2_grad/tuple/group_deps*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/sub_2_grad/Reshape*
T0
ы
4gradients/loss/sub_2_grad/tuple/control_dependency_1Identity#gradients/loss/sub_2_grad/Reshape_1+^gradients/loss/sub_2_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/sub_2_grad/Reshape_1*
T0
b
gradients/loss/add_5_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/add_5_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/add_5_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_5_grad/Shape!gradients/loss/add_5_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Щ
gradients/loss/add_5_grad/SumSum2gradients/loss/sub_2_grad/tuple/control_dependency/gradients/loss/add_5_grad/BroadcastGradientArgs*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0

!gradients/loss/add_5_grad/ReshapeReshapegradients/loss/add_5_grad/Sumgradients/loss/add_5_grad/Shape*
Tshape0*
_output_shapes
: *
T0
Э
gradients/loss/add_5_grad/Sum_1Sum2gradients/loss/sub_2_grad/tuple/control_dependency1gradients/loss/add_5_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
Ё
#gradients/loss/add_5_grad/Reshape_1Reshapegradients/loss/add_5_grad/Sum_1!gradients/loss/add_5_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/add_5_grad/tuple/group_depsNoOp"^gradients/loss/add_5_grad/Reshape$^gradients/loss/add_5_grad/Reshape_1
х
2gradients/loss/add_5_grad/tuple/control_dependencyIdentity!gradients/loss/add_5_grad/Reshape+^gradients/loss/add_5_grad/tuple/group_deps*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/add_5_grad/Reshape*
T0
ы
4gradients/loss/add_5_grad/tuple/control_dependency_1Identity#gradients/loss/add_5_grad/Reshape_1+^gradients/loss/add_5_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/add_5_grad/Reshape_1*
T0
q
'gradients/loss/Sum_1_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
О
!gradients/loss/Sum_1_grad/ReshapeReshape4gradients/loss/sub_2_grad/tuple/control_dependency_1'gradients/loss/Sum_1_grad/Reshape/shape*
Tshape0*
_output_shapes
:*
T0
i
gradients/loss/Sum_1_grad/ShapeShape
loss/Neg_1*
out_type0*
_output_shapes
:*
T0
Њ
gradients/loss/Sum_1_grad/TileTile!gradients/loss/Sum_1_grad/Reshapegradients/loss/Sum_1_grad/Shape*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ*
T0
b
gradients/loss/add_4_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/add_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/add_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_4_grad/Shape!gradients/loss/add_4_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Щ
gradients/loss/add_4_grad/SumSum2gradients/loss/add_5_grad/tuple/control_dependency/gradients/loss/add_4_grad/BroadcastGradientArgs*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0

!gradients/loss/add_4_grad/ReshapeReshapegradients/loss/add_4_grad/Sumgradients/loss/add_4_grad/Shape*
Tshape0*
_output_shapes
: *
T0
Э
gradients/loss/add_4_grad/Sum_1Sum2gradients/loss/add_5_grad/tuple/control_dependency1gradients/loss/add_4_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
Ё
#gradients/loss/add_4_grad/Reshape_1Reshapegradients/loss/add_4_grad/Sum_1!gradients/loss/add_4_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/add_4_grad/tuple/group_depsNoOp"^gradients/loss/add_4_grad/Reshape$^gradients/loss/add_4_grad/Reshape_1
х
2gradients/loss/add_4_grad/tuple/control_dependencyIdentity!gradients/loss/add_4_grad/Reshape+^gradients/loss/add_4_grad/tuple/group_deps*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/add_4_grad/Reshape*
T0
ы
4gradients/loss/add_4_grad/tuple/control_dependency_1Identity#gradients/loss/add_4_grad/Reshape_1+^gradients/loss/add_4_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/add_4_grad/Reshape_1*
T0
b
gradients/loss/add_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/add_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/add_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_3_grad/Shape!gradients/loss/add_3_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Ы
gradients/loss/add_3_grad/SumSum4gradients/loss/add_5_grad/tuple/control_dependency_1/gradients/loss/add_3_grad/BroadcastGradientArgs*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0

!gradients/loss/add_3_grad/ReshapeReshapegradients/loss/add_3_grad/Sumgradients/loss/add_3_grad/Shape*
Tshape0*
_output_shapes
: *
T0
Я
gradients/loss/add_3_grad/Sum_1Sum4gradients/loss/add_5_grad/tuple/control_dependency_11gradients/loss/add_3_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
Ё
#gradients/loss/add_3_grad/Reshape_1Reshapegradients/loss/add_3_grad/Sum_1!gradients/loss/add_3_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/add_3_grad/tuple/group_depsNoOp"^gradients/loss/add_3_grad/Reshape$^gradients/loss/add_3_grad/Reshape_1
х
2gradients/loss/add_3_grad/tuple/control_dependencyIdentity!gradients/loss/add_3_grad/Reshape+^gradients/loss/add_3_grad/tuple/group_deps*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/add_3_grad/Reshape*
T0
ы
4gradients/loss/add_3_grad/tuple/control_dependency_1Identity#gradients/loss/add_3_grad/Reshape_1+^gradients/loss/add_3_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/add_3_grad/Reshape_1*
T0
r
gradients/loss/Neg_1_grad/NegNeggradients/loss/Sum_1_grad/Tile*#
_output_shapes
:џџџџџџџџџ*
T0
b
gradients/loss/mul_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/mul_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_1_grad/Shape!gradients/loss/mul_1_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/mul_1_grad/mulMul2gradients/loss/add_4_grad/tuple/control_dependency
loss/Sum_2*
_output_shapes
: *
T0
Д
gradients/loss/mul_1_grad/SumSumgradients/loss/mul_1_grad/mul/gradients/loss/mul_1_grad/BroadcastGradientArgs*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0

!gradients/loss/mul_1_grad/ReshapeReshapegradients/loss/mul_1_grad/Sumgradients/loss/mul_1_grad/Shape*
Tshape0*
_output_shapes
: *
T0

gradients/loss/mul_1_grad/mul_1Mulloss/mul_1/x2gradients/loss/add_4_grad/tuple/control_dependency*
_output_shapes
: *
T0
К
gradients/loss/mul_1_grad/Sum_1Sumgradients/loss/mul_1_grad/mul_11gradients/loss/mul_1_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
Ё
#gradients/loss/mul_1_grad/Reshape_1Reshapegradients/loss/mul_1_grad/Sum_1!gradients/loss/mul_1_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/mul_1_grad/tuple/group_depsNoOp"^gradients/loss/mul_1_grad/Reshape$^gradients/loss/mul_1_grad/Reshape_1
х
2gradients/loss/mul_1_grad/tuple/control_dependencyIdentity!gradients/loss/mul_1_grad/Reshape+^gradients/loss/mul_1_grad/tuple/group_deps*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/mul_1_grad/Reshape*
T0
ы
4gradients/loss/mul_1_grad/tuple/control_dependency_1Identity#gradients/loss/mul_1_grad/Reshape_1+^gradients/loss/mul_1_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/mul_1_grad/Reshape_1*
T0
b
gradients/loss/add_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/add_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/add_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_2_grad/Shape!gradients/loss/add_2_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Ы
gradients/loss/add_2_grad/SumSum4gradients/loss/add_4_grad/tuple/control_dependency_1/gradients/loss/add_2_grad/BroadcastGradientArgs*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0

!gradients/loss/add_2_grad/ReshapeReshapegradients/loss/add_2_grad/Sumgradients/loss/add_2_grad/Shape*
Tshape0*
_output_shapes
: *
T0
Я
gradients/loss/add_2_grad/Sum_1Sum4gradients/loss/add_4_grad/tuple/control_dependency_11gradients/loss/add_2_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
Ё
#gradients/loss/add_2_grad/Reshape_1Reshapegradients/loss/add_2_grad/Sum_1!gradients/loss/add_2_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/add_2_grad/tuple/group_depsNoOp"^gradients/loss/add_2_grad/Reshape$^gradients/loss/add_2_grad/Reshape_1
х
2gradients/loss/add_2_grad/tuple/control_dependencyIdentity!gradients/loss/add_2_grad/Reshape+^gradients/loss/add_2_grad/tuple/group_deps*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/add_2_grad/Reshape*
T0
ы
4gradients/loss/add_2_grad/tuple/control_dependency_1Identity#gradients/loss/add_2_grad/Reshape_1+^gradients/loss/add_2_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/add_2_grad/Reshape_1*
T0
b
gradients/loss/mul_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/mul_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_3_grad/Shape!gradients/loss/mul_3_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/mul_3_grad/mulMul2gradients/loss/add_3_grad/tuple/control_dependency
loss/Sum_5*
_output_shapes
: *
T0
Д
gradients/loss/mul_3_grad/SumSumgradients/loss/mul_3_grad/mul/gradients/loss/mul_3_grad/BroadcastGradientArgs*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0

!gradients/loss/mul_3_grad/ReshapeReshapegradients/loss/mul_3_grad/Sumgradients/loss/mul_3_grad/Shape*
Tshape0*
_output_shapes
: *
T0

gradients/loss/mul_3_grad/mul_1Mulloss/mul_3/x2gradients/loss/add_3_grad/tuple/control_dependency*
_output_shapes
: *
T0
К
gradients/loss/mul_3_grad/Sum_1Sumgradients/loss/mul_3_grad/mul_11gradients/loss/mul_3_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
Ё
#gradients/loss/mul_3_grad/Reshape_1Reshapegradients/loss/mul_3_grad/Sum_1!gradients/loss/mul_3_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/mul_3_grad/tuple/group_depsNoOp"^gradients/loss/mul_3_grad/Reshape$^gradients/loss/mul_3_grad/Reshape_1
х
2gradients/loss/mul_3_grad/tuple/control_dependencyIdentity!gradients/loss/mul_3_grad/Reshape+^gradients/loss/mul_3_grad/tuple/group_deps*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/mul_3_grad/Reshape*
T0
ы
4gradients/loss/mul_3_grad/tuple/control_dependency_1Identity#gradients/loss/mul_3_grad/Reshape_1+^gradients/loss/mul_3_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/mul_3_grad/Reshape_1*
T0
q
'gradients/loss/Sum_6_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
О
!gradients/loss/Sum_6_grad/ReshapeReshape4gradients/loss/add_3_grad/tuple/control_dependency_1'gradients/loss/Sum_6_grad/Reshape/shape*
Tshape0*
_output_shapes
:*
T0
i
gradients/loss/Sum_6_grad/ShapeShape
loss/pow_4*
out_type0*
_output_shapes
:*
T0
Њ
gradients/loss/Sum_6_grad/TileTile!gradients/loss/Sum_6_grad/Reshapegradients/loss/Sum_6_grad/Shape*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ*
T0

"gradients/loss/Log_grad/Reciprocal
Reciprocal
loss/add_1^gradients/loss/Neg_1_grad/Neg*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/Log_grad/mulMulgradients/loss/Neg_1_grad/Neg"gradients/loss/Log_grad/Reciprocal*#
_output_shapes
:џџџџџџџџџ*
T0
x
'gradients/loss/Sum_2_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
Т
!gradients/loss/Sum_2_grad/ReshapeReshape4gradients/loss/mul_1_grad/tuple/control_dependency_1'gradients/loss/Sum_2_grad/Reshape/shape*
Tshape0*
_output_shapes

:*
T0
g
gradients/loss/Sum_2_grad/ShapeShapeloss/pow*
out_type0*
_output_shapes
:*
T0
Ў
gradients/loss/Sum_2_grad/TileTile!gradients/loss/Sum_2_grad/Reshapegradients/loss/Sum_2_grad/Shape*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ
*
T0
b
gradients/loss/mul_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/mul_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_2_grad/Shape!gradients/loss/mul_2_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/mul_2_grad/mulMul2gradients/loss/add_2_grad/tuple/control_dependency
loss/Sum_3*
_output_shapes
: *
T0
Д
gradients/loss/mul_2_grad/SumSumgradients/loss/mul_2_grad/mul/gradients/loss/mul_2_grad/BroadcastGradientArgs*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0

!gradients/loss/mul_2_grad/ReshapeReshapegradients/loss/mul_2_grad/Sumgradients/loss/mul_2_grad/Shape*
Tshape0*
_output_shapes
: *
T0

gradients/loss/mul_2_grad/mul_1Mulloss/mul_2/x2gradients/loss/add_2_grad/tuple/control_dependency*
_output_shapes
: *
T0
К
gradients/loss/mul_2_grad/Sum_1Sumgradients/loss/mul_2_grad/mul_11gradients/loss/mul_2_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
Ё
#gradients/loss/mul_2_grad/Reshape_1Reshapegradients/loss/mul_2_grad/Sum_1!gradients/loss/mul_2_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/mul_2_grad/tuple/group_depsNoOp"^gradients/loss/mul_2_grad/Reshape$^gradients/loss/mul_2_grad/Reshape_1
х
2gradients/loss/mul_2_grad/tuple/control_dependencyIdentity!gradients/loss/mul_2_grad/Reshape+^gradients/loss/mul_2_grad/tuple/group_deps*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/mul_2_grad/Reshape*
T0
ы
4gradients/loss/mul_2_grad/tuple/control_dependency_1Identity#gradients/loss/mul_2_grad/Reshape_1+^gradients/loss/mul_2_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/mul_2_grad/Reshape_1*
T0
q
'gradients/loss/Sum_4_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
О
!gradients/loss/Sum_4_grad/ReshapeReshape4gradients/loss/add_2_grad/tuple/control_dependency_1'gradients/loss/Sum_4_grad/Reshape/shape*
Tshape0*
_output_shapes
:*
T0
i
gradients/loss/Sum_4_grad/ShapeShape
loss/pow_2*
out_type0*
_output_shapes
:*
T0
Њ
gradients/loss/Sum_4_grad/TileTile!gradients/loss/Sum_4_grad/Reshapegradients/loss/Sum_4_grad/Shape*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ*
T0
x
'gradients/loss/Sum_5_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
Т
!gradients/loss/Sum_5_grad/ReshapeReshape4gradients/loss/mul_3_grad/tuple/control_dependency_1'gradients/loss/Sum_5_grad/Reshape/shape*
Tshape0*
_output_shapes

:*
T0
i
gradients/loss/Sum_5_grad/ShapeShape
loss/pow_3*
out_type0*
_output_shapes
:*
T0
Ў
gradients/loss/Sum_5_grad/TileTile!gradients/loss/Sum_5_grad/Reshapegradients/loss/Sum_5_grad/Shape*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ
*
T0
q
gradients/loss/pow_4_grad/ShapeShapeloss/neg_item_bias*
out_type0*
_output_shapes
:*
T0
d
!gradients/loss/pow_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_4_grad/Shape!gradients/loss/pow_4_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/pow_4_grad/mulMulgradients/loss/Sum_6_grad/Tileloss/pow_4/y*#
_output_shapes
:џџџџџџџџџ*
T0
d
gradients/loss/pow_4_grad/sub/yConst*
valueB
 *  ?*
_output_shapes
: *
dtype0
t
gradients/loss/pow_4_grad/subSubloss/pow_4/ygradients/loss/pow_4_grad/sub/y*
_output_shapes
: *
T0

gradients/loss/pow_4_grad/PowPowloss/neg_item_biasgradients/loss/pow_4_grad/sub*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_4_grad/mul_1Mulgradients/loss/pow_4_grad/mulgradients/loss/pow_4_grad/Pow*#
_output_shapes
:џџџџџџџџџ*
T0
Ж
gradients/loss/pow_4_grad/SumSumgradients/loss/pow_4_grad/mul_1/gradients/loss/pow_4_grad/BroadcastGradientArgs*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
Ј
!gradients/loss/pow_4_grad/ReshapeReshapegradients/loss/pow_4_grad/Sumgradients/loss/pow_4_grad/Shape*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
h
#gradients/loss/pow_4_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0

!gradients/loss/pow_4_grad/GreaterGreaterloss/neg_item_bias#gradients/loss/pow_4_grad/Greater/y*#
_output_shapes
:џџџџџџџџџ*
T0
f
gradients/loss/pow_4_grad/LogLogloss/neg_item_bias*#
_output_shapes
:џџџџџџџџџ*
T0
s
$gradients/loss/pow_4_grad/zeros_like	ZerosLikeloss/neg_item_bias*#
_output_shapes
:џџџџџџџџџ*
T0
Р
 gradients/loss/pow_4_grad/SelectSelect!gradients/loss/pow_4_grad/Greatergradients/loss/pow_4_grad/Log$gradients/loss/pow_4_grad/zeros_like*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_4_grad/mul_2Mulgradients/loss/Sum_6_grad/Tile
loss/pow_4*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_4_grad/mul_3Mulgradients/loss/pow_4_grad/mul_2 gradients/loss/pow_4_grad/Select*#
_output_shapes
:џџџџџџџџџ*
T0
К
gradients/loss/pow_4_grad/Sum_1Sumgradients/loss/pow_4_grad/mul_31gradients/loss/pow_4_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
Ё
#gradients/loss/pow_4_grad/Reshape_1Reshapegradients/loss/pow_4_grad/Sum_1!gradients/loss/pow_4_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/pow_4_grad/tuple/group_depsNoOp"^gradients/loss/pow_4_grad/Reshape$^gradients/loss/pow_4_grad/Reshape_1
ђ
2gradients/loss/pow_4_grad/tuple/control_dependencyIdentity!gradients/loss/pow_4_grad/Reshape+^gradients/loss/pow_4_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape*
T0
ы
4gradients/loss/pow_4_grad/tuple/control_dependency_1Identity#gradients/loss/pow_4_grad/Reshape_1+^gradients/loss/pow_4_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/pow_4_grad/Reshape_1*
T0
b
gradients/loss/add_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
i
!gradients/loss/add_1_grad/Shape_1Shapeloss/Exp*
out_type0*
_output_shapes
:*
T0
Щ
/gradients/loss/add_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_1_grad/Shape!gradients/loss/add_1_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
В
gradients/loss/add_1_grad/SumSumgradients/loss/Log_grad/mul/gradients/loss/add_1_grad/BroadcastGradientArgs*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0

!gradients/loss/add_1_grad/ReshapeReshapegradients/loss/add_1_grad/Sumgradients/loss/add_1_grad/Shape*
Tshape0*
_output_shapes
: *
T0
Ж
gradients/loss/add_1_grad/Sum_1Sumgradients/loss/Log_grad/mul1gradients/loss/add_1_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
Ў
#gradients/loss/add_1_grad/Reshape_1Reshapegradients/loss/add_1_grad/Sum_1!gradients/loss/add_1_grad/Shape_1*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
|
*gradients/loss/add_1_grad/tuple/group_depsNoOp"^gradients/loss/add_1_grad/Reshape$^gradients/loss/add_1_grad/Reshape_1
х
2gradients/loss/add_1_grad/tuple/control_dependencyIdentity!gradients/loss/add_1_grad/Reshape+^gradients/loss/add_1_grad/tuple/group_deps*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/add_1_grad/Reshape*
T0
ј
4gradients/loss/add_1_grad/tuple/control_dependency_1Identity#gradients/loss/add_1_grad/Reshape_1+^gradients/loss/add_1_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*6
_class,
*(loc:@gradients/loss/add_1_grad/Reshape_1*
T0
g
gradients/loss/pow_grad/ShapeShape
loss/users*
out_type0*
_output_shapes
:*
T0
b
gradients/loss/pow_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
У
-gradients/loss/pow_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_grad/Shapegradients/loss/pow_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/pow_grad/mulMulgradients/loss/Sum_2_grad/Tile
loss/pow/y*'
_output_shapes
:џџџџџџџџџ
*
T0
b
gradients/loss/pow_grad/sub/yConst*
valueB
 *  ?*
_output_shapes
: *
dtype0
n
gradients/loss/pow_grad/subSub
loss/pow/ygradients/loss/pow_grad/sub/y*
_output_shapes
: *
T0
}
gradients/loss/pow_grad/PowPow
loss/usersgradients/loss/pow_grad/sub*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_grad/mul_1Mulgradients/loss/pow_grad/mulgradients/loss/pow_grad/Pow*'
_output_shapes
:џџџџџџџџџ
*
T0
А
gradients/loss/pow_grad/SumSumgradients/loss/pow_grad/mul_1-gradients/loss/pow_grad/BroadcastGradientArgs*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
І
gradients/loss/pow_grad/ReshapeReshapegradients/loss/pow_grad/Sumgradients/loss/pow_grad/Shape*
Tshape0*'
_output_shapes
:џџџџџџџџџ
*
T0
f
!gradients/loss/pow_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0

gradients/loss/pow_grad/GreaterGreater
loss/users!gradients/loss/pow_grad/Greater/y*'
_output_shapes
:џџџџџџџџџ
*
T0
`
gradients/loss/pow_grad/LogLog
loss/users*'
_output_shapes
:џџџџџџџџџ
*
T0
m
"gradients/loss/pow_grad/zeros_like	ZerosLike
loss/users*'
_output_shapes
:џџџџџџџџџ
*
T0
М
gradients/loss/pow_grad/SelectSelectgradients/loss/pow_grad/Greatergradients/loss/pow_grad/Log"gradients/loss/pow_grad/zeros_like*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_grad/mul_2Mulgradients/loss/Sum_2_grad/Tileloss/pow*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_grad/mul_3Mulgradients/loss/pow_grad/mul_2gradients/loss/pow_grad/Select*'
_output_shapes
:џџџџџџџџџ
*
T0
Д
gradients/loss/pow_grad/Sum_1Sumgradients/loss/pow_grad/mul_3/gradients/loss/pow_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0

!gradients/loss/pow_grad/Reshape_1Reshapegradients/loss/pow_grad/Sum_1gradients/loss/pow_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
v
(gradients/loss/pow_grad/tuple/group_depsNoOp ^gradients/loss/pow_grad/Reshape"^gradients/loss/pow_grad/Reshape_1
ю
0gradients/loss/pow_grad/tuple/control_dependencyIdentitygradients/loss/pow_grad/Reshape)^gradients/loss/pow_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape*
T0
у
2gradients/loss/pow_grad/tuple/control_dependency_1Identity!gradients/loss/pow_grad/Reshape_1)^gradients/loss/pow_grad/tuple/group_deps*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/pow_grad/Reshape_1*
T0
x
'gradients/loss/Sum_3_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
Т
!gradients/loss/Sum_3_grad/ReshapeReshape4gradients/loss/mul_2_grad/tuple/control_dependency_1'gradients/loss/Sum_3_grad/Reshape/shape*
Tshape0*
_output_shapes

:*
T0
i
gradients/loss/Sum_3_grad/ShapeShape
loss/pow_1*
out_type0*
_output_shapes
:*
T0
Ў
gradients/loss/Sum_3_grad/TileTile!gradients/loss/Sum_3_grad/Reshapegradients/loss/Sum_3_grad/Shape*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ
*
T0
q
gradients/loss/pow_2_grad/ShapeShapeloss/pos_item_bias*
out_type0*
_output_shapes
:*
T0
d
!gradients/loss/pow_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_2_grad/Shape!gradients/loss/pow_2_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/pow_2_grad/mulMulgradients/loss/Sum_4_grad/Tileloss/pow_2/y*#
_output_shapes
:џџџџџџџџџ*
T0
d
gradients/loss/pow_2_grad/sub/yConst*
valueB
 *  ?*
_output_shapes
: *
dtype0
t
gradients/loss/pow_2_grad/subSubloss/pow_2/ygradients/loss/pow_2_grad/sub/y*
_output_shapes
: *
T0

gradients/loss/pow_2_grad/PowPowloss/pos_item_biasgradients/loss/pow_2_grad/sub*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_2_grad/mul_1Mulgradients/loss/pow_2_grad/mulgradients/loss/pow_2_grad/Pow*#
_output_shapes
:џџџџџџџџџ*
T0
Ж
gradients/loss/pow_2_grad/SumSumgradients/loss/pow_2_grad/mul_1/gradients/loss/pow_2_grad/BroadcastGradientArgs*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
Ј
!gradients/loss/pow_2_grad/ReshapeReshapegradients/loss/pow_2_grad/Sumgradients/loss/pow_2_grad/Shape*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
h
#gradients/loss/pow_2_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0

!gradients/loss/pow_2_grad/GreaterGreaterloss/pos_item_bias#gradients/loss/pow_2_grad/Greater/y*#
_output_shapes
:џџџџџџџџџ*
T0
f
gradients/loss/pow_2_grad/LogLogloss/pos_item_bias*#
_output_shapes
:џџџџџџџџџ*
T0
s
$gradients/loss/pow_2_grad/zeros_like	ZerosLikeloss/pos_item_bias*#
_output_shapes
:џџџџџџџџџ*
T0
Р
 gradients/loss/pow_2_grad/SelectSelect!gradients/loss/pow_2_grad/Greatergradients/loss/pow_2_grad/Log$gradients/loss/pow_2_grad/zeros_like*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_2_grad/mul_2Mulgradients/loss/Sum_4_grad/Tile
loss/pow_2*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_2_grad/mul_3Mulgradients/loss/pow_2_grad/mul_2 gradients/loss/pow_2_grad/Select*#
_output_shapes
:џџџџџџџџџ*
T0
К
gradients/loss/pow_2_grad/Sum_1Sumgradients/loss/pow_2_grad/mul_31gradients/loss/pow_2_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
Ё
#gradients/loss/pow_2_grad/Reshape_1Reshapegradients/loss/pow_2_grad/Sum_1!gradients/loss/pow_2_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/pow_2_grad/tuple/group_depsNoOp"^gradients/loss/pow_2_grad/Reshape$^gradients/loss/pow_2_grad/Reshape_1
ђ
2gradients/loss/pow_2_grad/tuple/control_dependencyIdentity!gradients/loss/pow_2_grad/Reshape+^gradients/loss/pow_2_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape*
T0
ы
4gradients/loss/pow_2_grad/tuple/control_dependency_1Identity#gradients/loss/pow_2_grad/Reshape_1+^gradients/loss/pow_2_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/pow_2_grad/Reshape_1*
T0
m
gradients/loss/pow_3_grad/ShapeShapeloss/neg_items*
out_type0*
_output_shapes
:*
T0
d
!gradients/loss/pow_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_3_grad/Shape!gradients/loss/pow_3_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/pow_3_grad/mulMulgradients/loss/Sum_5_grad/Tileloss/pow_3/y*'
_output_shapes
:џџџџџџџџџ
*
T0
d
gradients/loss/pow_3_grad/sub/yConst*
valueB
 *  ?*
_output_shapes
: *
dtype0
t
gradients/loss/pow_3_grad/subSubloss/pow_3/ygradients/loss/pow_3_grad/sub/y*
_output_shapes
: *
T0

gradients/loss/pow_3_grad/PowPowloss/neg_itemsgradients/loss/pow_3_grad/sub*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_3_grad/mul_1Mulgradients/loss/pow_3_grad/mulgradients/loss/pow_3_grad/Pow*'
_output_shapes
:џџџџџџџџџ
*
T0
Ж
gradients/loss/pow_3_grad/SumSumgradients/loss/pow_3_grad/mul_1/gradients/loss/pow_3_grad/BroadcastGradientArgs*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
Ќ
!gradients/loss/pow_3_grad/ReshapeReshapegradients/loss/pow_3_grad/Sumgradients/loss/pow_3_grad/Shape*
Tshape0*'
_output_shapes
:џџџџџџџџџ
*
T0
h
#gradients/loss/pow_3_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0

!gradients/loss/pow_3_grad/GreaterGreaterloss/neg_items#gradients/loss/pow_3_grad/Greater/y*'
_output_shapes
:џџџџџџџџџ
*
T0
f
gradients/loss/pow_3_grad/LogLogloss/neg_items*'
_output_shapes
:џџџџџџџџџ
*
T0
s
$gradients/loss/pow_3_grad/zeros_like	ZerosLikeloss/neg_items*'
_output_shapes
:џџџџџџџџџ
*
T0
Ф
 gradients/loss/pow_3_grad/SelectSelect!gradients/loss/pow_3_grad/Greatergradients/loss/pow_3_grad/Log$gradients/loss/pow_3_grad/zeros_like*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_3_grad/mul_2Mulgradients/loss/Sum_5_grad/Tile
loss/pow_3*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_3_grad/mul_3Mulgradients/loss/pow_3_grad/mul_2 gradients/loss/pow_3_grad/Select*'
_output_shapes
:џџџџџџџџџ
*
T0
К
gradients/loss/pow_3_grad/Sum_1Sumgradients/loss/pow_3_grad/mul_31gradients/loss/pow_3_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
Ё
#gradients/loss/pow_3_grad/Reshape_1Reshapegradients/loss/pow_3_grad/Sum_1!gradients/loss/pow_3_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/pow_3_grad/tuple/group_depsNoOp"^gradients/loss/pow_3_grad/Reshape$^gradients/loss/pow_3_grad/Reshape_1
і
2gradients/loss/pow_3_grad/tuple/control_dependencyIdentity!gradients/loss/pow_3_grad/Reshape+^gradients/loss/pow_3_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape*
T0
ы
4gradients/loss/pow_3_grad/tuple/control_dependency_1Identity#gradients/loss/pow_3_grad/Reshape_1+^gradients/loss/pow_3_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/pow_3_grad/Reshape_1*
T0

gradients/loss/Exp_grad/mulMul4gradients/loss/add_1_grad/tuple/control_dependency_1loss/Exp*#
_output_shapes
:џџџџџџџџџ*
T0
m
gradients/loss/pow_1_grad/ShapeShapeloss/pos_items*
out_type0*
_output_shapes
:*
T0
d
!gradients/loss/pow_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_1_grad/Shape!gradients/loss/pow_1_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/pow_1_grad/mulMulgradients/loss/Sum_3_grad/Tileloss/pow_1/y*'
_output_shapes
:џџџџџџџџџ
*
T0
d
gradients/loss/pow_1_grad/sub/yConst*
valueB
 *  ?*
_output_shapes
: *
dtype0
t
gradients/loss/pow_1_grad/subSubloss/pow_1/ygradients/loss/pow_1_grad/sub/y*
_output_shapes
: *
T0

gradients/loss/pow_1_grad/PowPowloss/pos_itemsgradients/loss/pow_1_grad/sub*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_1_grad/mul_1Mulgradients/loss/pow_1_grad/mulgradients/loss/pow_1_grad/Pow*'
_output_shapes
:џџџџџџџџџ
*
T0
Ж
gradients/loss/pow_1_grad/SumSumgradients/loss/pow_1_grad/mul_1/gradients/loss/pow_1_grad/BroadcastGradientArgs*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
Ќ
!gradients/loss/pow_1_grad/ReshapeReshapegradients/loss/pow_1_grad/Sumgradients/loss/pow_1_grad/Shape*
Tshape0*'
_output_shapes
:џџџџџџџџџ
*
T0
h
#gradients/loss/pow_1_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0

!gradients/loss/pow_1_grad/GreaterGreaterloss/pos_items#gradients/loss/pow_1_grad/Greater/y*'
_output_shapes
:џџџџџџџџџ
*
T0
f
gradients/loss/pow_1_grad/LogLogloss/pos_items*'
_output_shapes
:џџџџџџџџџ
*
T0
s
$gradients/loss/pow_1_grad/zeros_like	ZerosLikeloss/pos_items*'
_output_shapes
:џџџџџџџџџ
*
T0
Ф
 gradients/loss/pow_1_grad/SelectSelect!gradients/loss/pow_1_grad/Greatergradients/loss/pow_1_grad/Log$gradients/loss/pow_1_grad/zeros_like*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_1_grad/mul_2Mulgradients/loss/Sum_3_grad/Tile
loss/pow_1*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_1_grad/mul_3Mulgradients/loss/pow_1_grad/mul_2 gradients/loss/pow_1_grad/Select*'
_output_shapes
:џџџџџџџџџ
*
T0
К
gradients/loss/pow_1_grad/Sum_1Sumgradients/loss/pow_1_grad/mul_31gradients/loss/pow_1_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
Ё
#gradients/loss/pow_1_grad/Reshape_1Reshapegradients/loss/pow_1_grad/Sum_1!gradients/loss/pow_1_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/pow_1_grad/tuple/group_depsNoOp"^gradients/loss/pow_1_grad/Reshape$^gradients/loss/pow_1_grad/Reshape_1
і
2gradients/loss/pow_1_grad/tuple/control_dependencyIdentity!gradients/loss/pow_1_grad/Reshape+^gradients/loss/pow_1_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape*
T0
ы
4gradients/loss/pow_1_grad/tuple/control_dependency_1Identity#gradients/loss/pow_1_grad/Reshape_1+^gradients/loss/pow_1_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/pow_1_grad/Reshape_1*
T0
m
gradients/loss/Neg_grad/NegNeggradients/loss/Exp_grad/mul*#
_output_shapes
:џџџџџџџџџ*
T0
g
gradients/loss/add_grad/ShapeShape
loss/sub_1*
out_type0*
_output_shapes
:*
T0
g
gradients/loss/add_grad/Shape_1Shapeloss/Sum*
out_type0*
_output_shapes
:*
T0
У
-gradients/loss/add_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_grad/Shapegradients/loss/add_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Ў
gradients/loss/add_grad/SumSumgradients/loss/Neg_grad/Neg-gradients/loss/add_grad/BroadcastGradientArgs*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
Ђ
gradients/loss/add_grad/ReshapeReshapegradients/loss/add_grad/Sumgradients/loss/add_grad/Shape*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
В
gradients/loss/add_grad/Sum_1Sumgradients/loss/Neg_grad/Neg/gradients/loss/add_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
Ј
!gradients/loss/add_grad/Reshape_1Reshapegradients/loss/add_grad/Sum_1gradients/loss/add_grad/Shape_1*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
v
(gradients/loss/add_grad/tuple/group_depsNoOp ^gradients/loss/add_grad/Reshape"^gradients/loss/add_grad/Reshape_1
ъ
0gradients/loss/add_grad/tuple/control_dependencyIdentitygradients/loss/add_grad/Reshape)^gradients/loss/add_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*2
_class(
&$loc:@gradients/loss/add_grad/Reshape*
T0
№
2gradients/loss/add_grad/tuple/control_dependency_1Identity!gradients/loss/add_grad/Reshape_1)^gradients/loss/add_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*4
_class*
(&loc:@gradients/loss/add_grad/Reshape_1*
T0
q
gradients/loss/sub_1_grad/ShapeShapeloss/pos_item_bias*
out_type0*
_output_shapes
:*
T0
s
!gradients/loss/sub_1_grad/Shape_1Shapeloss/neg_item_bias*
out_type0*
_output_shapes
:*
T0
Щ
/gradients/loss/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_1_grad/Shape!gradients/loss/sub_1_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Ч
gradients/loss/sub_1_grad/SumSum0gradients/loss/add_grad/tuple/control_dependency/gradients/loss/sub_1_grad/BroadcastGradientArgs*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
Ј
!gradients/loss/sub_1_grad/ReshapeReshapegradients/loss/sub_1_grad/Sumgradients/loss/sub_1_grad/Shape*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
Ы
gradients/loss/sub_1_grad/Sum_1Sum0gradients/loss/add_grad/tuple/control_dependency1gradients/loss/sub_1_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
h
gradients/loss/sub_1_grad/NegNeggradients/loss/sub_1_grad/Sum_1*
_output_shapes
:*
T0
Ќ
#gradients/loss/sub_1_grad/Reshape_1Reshapegradients/loss/sub_1_grad/Neg!gradients/loss/sub_1_grad/Shape_1*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
|
*gradients/loss/sub_1_grad/tuple/group_depsNoOp"^gradients/loss/sub_1_grad/Reshape$^gradients/loss/sub_1_grad/Reshape_1
ђ
2gradients/loss/sub_1_grad/tuple/control_dependencyIdentity!gradients/loss/sub_1_grad/Reshape+^gradients/loss/sub_1_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*4
_class*
(&loc:@gradients/loss/sub_1_grad/Reshape*
T0
ј
4gradients/loss/sub_1_grad/tuple/control_dependency_1Identity#gradients/loss/sub_1_grad/Reshape_1+^gradients/loss/sub_1_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*6
_class,
*(loc:@gradients/loss/sub_1_grad/Reshape_1*
T0
e
gradients/loss/Sum_grad/ShapeShapeloss/mul*
out_type0*
_output_shapes
:*
T0
^
gradients/loss/Sum_grad/SizeConst*
value	B :*
_output_shapes
: *
dtype0
}
gradients/loss/Sum_grad/addAddloss/Sum/reduction_indicesgradients/loss/Sum_grad/Size*
_output_shapes
: *
T0

gradients/loss/Sum_grad/modFloorModgradients/loss/Sum_grad/addgradients/loss/Sum_grad/Size*
_output_shapes
: *
T0
b
gradients/loss/Sum_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
e
#gradients/loss/Sum_grad/range/startConst*
value	B : *
_output_shapes
: *
dtype0
e
#gradients/loss/Sum_grad/range/deltaConst*
value	B :*
_output_shapes
: *
dtype0
Ж
gradients/loss/Sum_grad/rangeRange#gradients/loss/Sum_grad/range/startgradients/loss/Sum_grad/Size#gradients/loss/Sum_grad/range/delta*
_output_shapes
:*

Tidx0
d
"gradients/loss/Sum_grad/Fill/valueConst*
value	B :*
_output_shapes
: *
dtype0

gradients/loss/Sum_grad/FillFillgradients/loss/Sum_grad/Shape_1"gradients/loss/Sum_grad/Fill/value*
_output_shapes
: *
T0
ц
%gradients/loss/Sum_grad/DynamicStitchDynamicStitchgradients/loss/Sum_grad/rangegradients/loss/Sum_grad/modgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Fill*#
_output_shapes
:џџџџџџџџџ*
N*
T0
c
!gradients/loss/Sum_grad/Maximum/yConst*
value	B :*
_output_shapes
: *
dtype0
Ђ
gradients/loss/Sum_grad/MaximumMaximum%gradients/loss/Sum_grad/DynamicStitch!gradients/loss/Sum_grad/Maximum/y*#
_output_shapes
:џџџџџџџџџ*
T0

 gradients/loss/Sum_grad/floordivFloorDivgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Maximum*
_output_shapes
:*
T0
Ж
gradients/loss/Sum_grad/ReshapeReshape2gradients/loss/add_grad/tuple/control_dependency_1%gradients/loss/Sum_grad/DynamicStitch*
Tshape0*
_output_shapes
:*
T0
Ћ
gradients/loss/Sum_grad/TileTilegradients/loss/Sum_grad/Reshape gradients/loss/Sum_grad/floordiv*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ
*
T0
ы
gradients/AddNAddN2gradients/loss/pow_2_grad/tuple/control_dependency2gradients/loss/sub_1_grad/tuple/control_dependency*#
_output_shapes
:џџџџџџџџџ*
N*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape*
T0

'gradients/loss/pos_item_bias_grad/ShapeConst*
valueB:э*
_output_shapes
:*&
_class
loc:@variables/item_bias*
dtype0

&gradients/loss/pos_item_bias_grad/SizeSizeplaceholders/sampled_pos_items*
out_type0*
_output_shapes
: *
T0
r
0gradients/loss/pos_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
Х
,gradients/loss/pos_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/pos_item_bias_grad/Size0gradients/loss/pos_item_bias_grad/ExpandDims/dim*
_output_shapes
:*

Tdim0*
T0

5gradients/loss/pos_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0

7gradients/loss/pos_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0

7gradients/loss/pos_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
Ѕ
/gradients/loss/pos_item_bias_grad/strided_sliceStridedSlice'gradients/loss/pos_item_bias_grad/Shape5gradients/loss/pos_item_bias_grad/strided_slice/stack7gradients/loss/pos_item_bias_grad/strided_slice/stack_17gradients/loss/pos_item_bias_grad/strided_slice/stack_2*
_output_shapes
: *
ellipsis_mask *

begin_mask *
shrink_axis_mask *
end_mask*
new_axis_mask *
Index0*
T0
o
-gradients/loss/pos_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ќ
(gradients/loss/pos_item_bias_grad/concatConcatV2,gradients/loss/pos_item_bias_grad/ExpandDims/gradients/loss/pos_item_bias_grad/strided_slice-gradients/loss/pos_item_bias_grad/concat/axis*
T0*
_output_shapes
:*
N*

Tidx0
Њ
)gradients/loss/pos_item_bias_grad/ReshapeReshapegradients/AddN(gradients/loss/pos_item_bias_grad/concat*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
Р
+gradients/loss/pos_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_pos_items,gradients/loss/pos_item_bias_grad/ExpandDims*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
я
gradients/AddN_1AddN2gradients/loss/pow_4_grad/tuple/control_dependency4gradients/loss/sub_1_grad/tuple/control_dependency_1*#
_output_shapes
:џџџџџџџџџ*
N*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape*
T0

'gradients/loss/neg_item_bias_grad/ShapeConst*
valueB:э*
_output_shapes
:*&
_class
loc:@variables/item_bias*
dtype0

&gradients/loss/neg_item_bias_grad/SizeSizeplaceholders/sampled_neg_items*
out_type0*
_output_shapes
: *
T0
r
0gradients/loss/neg_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
Х
,gradients/loss/neg_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/neg_item_bias_grad/Size0gradients/loss/neg_item_bias_grad/ExpandDims/dim*
_output_shapes
:*

Tdim0*
T0

5gradients/loss/neg_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0

7gradients/loss/neg_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0

7gradients/loss/neg_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
Ѕ
/gradients/loss/neg_item_bias_grad/strided_sliceStridedSlice'gradients/loss/neg_item_bias_grad/Shape5gradients/loss/neg_item_bias_grad/strided_slice/stack7gradients/loss/neg_item_bias_grad/strided_slice/stack_17gradients/loss/neg_item_bias_grad/strided_slice/stack_2*
_output_shapes
: *
ellipsis_mask *

begin_mask *
shrink_axis_mask *
end_mask*
new_axis_mask *
Index0*
T0
o
-gradients/loss/neg_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ќ
(gradients/loss/neg_item_bias_grad/concatConcatV2,gradients/loss/neg_item_bias_grad/ExpandDims/gradients/loss/neg_item_bias_grad/strided_slice-gradients/loss/neg_item_bias_grad/concat/axis*
T0*
_output_shapes
:*
N*

Tidx0
Ќ
)gradients/loss/neg_item_bias_grad/ReshapeReshapegradients/AddN_1(gradients/loss/neg_item_bias_grad/concat*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
Р
+gradients/loss/neg_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_neg_items,gradients/loss/neg_item_bias_grad/ExpandDims*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
g
gradients/loss/mul_grad/ShapeShape
loss/users*
out_type0*
_output_shapes
:*
T0
g
gradients/loss/mul_grad/Shape_1Shapeloss/sub*
out_type0*
_output_shapes
:*
T0
У
-gradients/loss/mul_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_grad/Shapegradients/loss/mul_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
|
gradients/loss/mul_grad/mulMulgradients/loss/Sum_grad/Tileloss/sub*'
_output_shapes
:џџџџџџџџџ
*
T0
Ў
gradients/loss/mul_grad/SumSumgradients/loss/mul_grad/mul-gradients/loss/mul_grad/BroadcastGradientArgs*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
І
gradients/loss/mul_grad/ReshapeReshapegradients/loss/mul_grad/Sumgradients/loss/mul_grad/Shape*
Tshape0*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/mul_grad/mul_1Mul
loss/usersgradients/loss/Sum_grad/Tile*'
_output_shapes
:џџџџџџџџџ
*
T0
Д
gradients/loss/mul_grad/Sum_1Sumgradients/loss/mul_grad/mul_1/gradients/loss/mul_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
Ќ
!gradients/loss/mul_grad/Reshape_1Reshapegradients/loss/mul_grad/Sum_1gradients/loss/mul_grad/Shape_1*
Tshape0*'
_output_shapes
:џџџџџџџџџ
*
T0
v
(gradients/loss/mul_grad/tuple/group_depsNoOp ^gradients/loss/mul_grad/Reshape"^gradients/loss/mul_grad/Reshape_1
ю
0gradients/loss/mul_grad/tuple/control_dependencyIdentitygradients/loss/mul_grad/Reshape)^gradients/loss/mul_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*2
_class(
&$loc:@gradients/loss/mul_grad/Reshape*
T0
є
2gradients/loss/mul_grad/tuple/control_dependency_1Identity!gradients/loss/mul_grad/Reshape_1)^gradients/loss/mul_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*4
_class*
(&loc:@gradients/loss/mul_grad/Reshape_1*
T0
W
gradients/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
Ь
gradients/concatConcatV2)gradients/loss/pos_item_bias_grad/Reshape)gradients/loss/neg_item_bias_grad/Reshapegradients/concat/axis*
T0*#
_output_shapes
:џџџџџџџџџ*
N*

Tidx0
Y
gradients/concat_1/axisConst*
value	B : *
_output_shapes
: *
dtype0
д
gradients/concat_1ConcatV2+gradients/loss/pos_item_bias_grad/Reshape_1+gradients/loss/neg_item_bias_grad/Reshape_1gradients/concat_1/axis*
T0*#
_output_shapes
:џџџџџџџџџ*
N*

Tidx0
ы
gradients/AddN_2AddN0gradients/loss/pow_grad/tuple/control_dependency0gradients/loss/mul_grad/tuple/control_dependency*'
_output_shapes
:џџџџџџџџџ
*
N*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape*
T0

gradients/loss/users_grad/ShapeConst*
valueB"  
   *
_output_shapes
:*)
_class
loc:@variables/user_factors*
dtype0
s
gradients/loss/users_grad/SizeSizeplaceholders/sampled_users*
out_type0*
_output_shapes
: *
T0
j
(gradients/loss/users_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
­
$gradients/loss/users_grad/ExpandDims
ExpandDimsgradients/loss/users_grad/Size(gradients/loss/users_grad/ExpandDims/dim*
_output_shapes
:*

Tdim0*
T0
w
-gradients/loss/users_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
y
/gradients/loss/users_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
y
/gradients/loss/users_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
џ
'gradients/loss/users_grad/strided_sliceStridedSlicegradients/loss/users_grad/Shape-gradients/loss/users_grad/strided_slice/stack/gradients/loss/users_grad/strided_slice/stack_1/gradients/loss/users_grad/strided_slice/stack_2*
_output_shapes
:*
ellipsis_mask *

begin_mask *
shrink_axis_mask *
end_mask*
new_axis_mask *
Index0*
T0
g
%gradients/loss/users_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
м
 gradients/loss/users_grad/concatConcatV2$gradients/loss/users_grad/ExpandDims'gradients/loss/users_grad/strided_slice%gradients/loss/users_grad/concat/axis*
T0*
_output_shapes
:*
N*

Tidx0
Љ
!gradients/loss/users_grad/ReshapeReshapegradients/AddN_2 gradients/loss/users_grad/concat*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
T0
Ќ
#gradients/loss/users_grad/Reshape_1Reshapeplaceholders/sampled_users$gradients/loss/users_grad/ExpandDims*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
k
gradients/loss/sub_grad/ShapeShapeloss/pos_items*
out_type0*
_output_shapes
:*
T0
m
gradients/loss/sub_grad/Shape_1Shapeloss/neg_items*
out_type0*
_output_shapes
:*
T0
У
-gradients/loss/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_grad/Shapegradients/loss/sub_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Х
gradients/loss/sub_grad/SumSum2gradients/loss/mul_grad/tuple/control_dependency_1-gradients/loss/sub_grad/BroadcastGradientArgs*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
І
gradients/loss/sub_grad/ReshapeReshapegradients/loss/sub_grad/Sumgradients/loss/sub_grad/Shape*
Tshape0*'
_output_shapes
:џџџџџџџџџ
*
T0
Щ
gradients/loss/sub_grad/Sum_1Sum2gradients/loss/mul_grad/tuple/control_dependency_1/gradients/loss/sub_grad/BroadcastGradientArgs:1*
	keep_dims( *
T0*
_output_shapes
:*

Tidx0
d
gradients/loss/sub_grad/NegNeggradients/loss/sub_grad/Sum_1*
_output_shapes
:*
T0
Њ
!gradients/loss/sub_grad/Reshape_1Reshapegradients/loss/sub_grad/Neggradients/loss/sub_grad/Shape_1*
Tshape0*'
_output_shapes
:џџџџџџџџџ
*
T0
v
(gradients/loss/sub_grad/tuple/group_depsNoOp ^gradients/loss/sub_grad/Reshape"^gradients/loss/sub_grad/Reshape_1
ю
0gradients/loss/sub_grad/tuple/control_dependencyIdentitygradients/loss/sub_grad/Reshape)^gradients/loss/sub_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*2
_class(
&$loc:@gradients/loss/sub_grad/Reshape*
T0
є
2gradients/loss/sub_grad/tuple/control_dependency_1Identity!gradients/loss/sub_grad/Reshape_1)^gradients/loss/sub_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*4
_class*
(&loc:@gradients/loss/sub_grad/Reshape_1*
T0
я
gradients/AddN_3AddN2gradients/loss/pow_1_grad/tuple/control_dependency0gradients/loss/sub_grad/tuple/control_dependency*'
_output_shapes
:џџџџџџџџџ
*
N*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape*
T0

#gradients/loss/pos_items_grad/ShapeConst*
valueB"m  
   *
_output_shapes
:*)
_class
loc:@variables/item_factors*
dtype0
{
"gradients/loss/pos_items_grad/SizeSizeplaceholders/sampled_pos_items*
out_type0*
_output_shapes
: *
T0
n
,gradients/loss/pos_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
Й
(gradients/loss/pos_items_grad/ExpandDims
ExpandDims"gradients/loss/pos_items_grad/Size,gradients/loss/pos_items_grad/ExpandDims/dim*
_output_shapes
:*

Tdim0*
T0
{
1gradients/loss/pos_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
}
3gradients/loss/pos_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
}
3gradients/loss/pos_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0

+gradients/loss/pos_items_grad/strided_sliceStridedSlice#gradients/loss/pos_items_grad/Shape1gradients/loss/pos_items_grad/strided_slice/stack3gradients/loss/pos_items_grad/strided_slice/stack_13gradients/loss/pos_items_grad/strided_slice/stack_2*
_output_shapes
:*
ellipsis_mask *

begin_mask *
shrink_axis_mask *
end_mask*
new_axis_mask *
Index0*
T0
k
)gradients/loss/pos_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
$gradients/loss/pos_items_grad/concatConcatV2(gradients/loss/pos_items_grad/ExpandDims+gradients/loss/pos_items_grad/strided_slice)gradients/loss/pos_items_grad/concat/axis*
T0*
_output_shapes
:*
N*

Tidx0
Б
%gradients/loss/pos_items_grad/ReshapeReshapegradients/AddN_3$gradients/loss/pos_items_grad/concat*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
T0
И
'gradients/loss/pos_items_grad/Reshape_1Reshapeplaceholders/sampled_pos_items(gradients/loss/pos_items_grad/ExpandDims*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
ё
gradients/AddN_4AddN2gradients/loss/pow_3_grad/tuple/control_dependency2gradients/loss/sub_grad/tuple/control_dependency_1*'
_output_shapes
:џџџџџџџџџ
*
N*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape*
T0

#gradients/loss/neg_items_grad/ShapeConst*
valueB"m  
   *
_output_shapes
:*)
_class
loc:@variables/item_factors*
dtype0
{
"gradients/loss/neg_items_grad/SizeSizeplaceholders/sampled_neg_items*
out_type0*
_output_shapes
: *
T0
n
,gradients/loss/neg_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
Й
(gradients/loss/neg_items_grad/ExpandDims
ExpandDims"gradients/loss/neg_items_grad/Size,gradients/loss/neg_items_grad/ExpandDims/dim*
_output_shapes
:*

Tdim0*
T0
{
1gradients/loss/neg_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
}
3gradients/loss/neg_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
}
3gradients/loss/neg_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0

+gradients/loss/neg_items_grad/strided_sliceStridedSlice#gradients/loss/neg_items_grad/Shape1gradients/loss/neg_items_grad/strided_slice/stack3gradients/loss/neg_items_grad/strided_slice/stack_13gradients/loss/neg_items_grad/strided_slice/stack_2*
_output_shapes
:*
ellipsis_mask *

begin_mask *
shrink_axis_mask *
end_mask*
new_axis_mask *
Index0*
T0
k
)gradients/loss/neg_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
$gradients/loss/neg_items_grad/concatConcatV2(gradients/loss/neg_items_grad/ExpandDims+gradients/loss/neg_items_grad/strided_slice)gradients/loss/neg_items_grad/concat/axis*
T0*
_output_shapes
:*
N*

Tidx0
Б
%gradients/loss/neg_items_grad/ReshapeReshapegradients/AddN_4$gradients/loss/neg_items_grad/concat*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
T0
И
'gradients/loss/neg_items_grad/Reshape_1Reshapeplaceholders/sampled_neg_items(gradients/loss/neg_items_grad/ExpandDims*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
Y
gradients/concat_2/axisConst*
value	B : *
_output_shapes
: *
dtype0
е
gradients/concat_2ConcatV2%gradients/loss/pos_items_grad/Reshape%gradients/loss/neg_items_grad/Reshapegradients/concat_2/axis*
T0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
N*

Tidx0
Y
gradients/concat_3/axisConst*
value	B : *
_output_shapes
: *
dtype0
Ь
gradients/concat_3ConcatV2'gradients/loss/pos_items_grad/Reshape_1'gradients/loss/neg_items_grad/Reshape_1gradients/concat_3/axis*
T0*#
_output_shapes
:џџџџџџџџџ*
N*

Tidx0
b
GradientDescent/learning_rateConst*
valueB
 *ЭЬЬ=*
_output_shapes
: *
dtype0
р
1GradientDescent/update_variables/user_factors/mulMul!gradients/loss/users_grad/ReshapeGradientDescent/learning_rate*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*)
_class
loc:@variables/user_factors*
T0
Ў
8GradientDescent/update_variables/user_factors/ScatterSub
ScatterSubvariables/user_factors#gradients/loss/users_grad/Reshape_11GradientDescent/update_variables/user_factors/mul*
use_locking( *
_output_shapes
:	
*
Tindices0*)
_class
loc:@variables/user_factors*
T0
б
1GradientDescent/update_variables/item_factors/mulMulgradients/concat_2GradientDescent/learning_rate*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*)
_class
loc:@variables/item_factors*
T0

8GradientDescent/update_variables/item_factors/ScatterSub
ScatterSubvariables/item_factorsgradients/concat_31GradientDescent/update_variables/item_factors/mul*
use_locking( *
_output_shapes
:	э
*
Tindices0*)
_class
loc:@variables/item_factors*
T0
М
.GradientDescent/update_variables/item_bias/mulMulgradients/concatGradientDescent/learning_rate*#
_output_shapes
:џџџџџџџџџ*&
_class
loc:@variables/item_bias*
T0

5GradientDescent/update_variables/item_bias/ScatterSub
ScatterSubvariables/item_biasgradients/concat_1.GradientDescent/update_variables/item_bias/mul*
use_locking( *
_output_shapes	
:э*
Tindices0*&
_class
loc:@variables/item_bias*
T0
Х
GradientDescentNoOp9^GradientDescent/update_variables/user_factors/ScatterSub9^GradientDescent/update_variables/item_factors/ScatterSub6^GradientDescent/update_variables/item_bias/ScatterSub
R
loss_1/tagsConst*
valueB Bloss_1*
_output_shapes
: *
dtype0
Q
loss_1ScalarSummaryloss_1/tags
loss/sub_2*
_output_shapes
: *
T0
K
Merge/MergeSummaryMergeSummaryloss_1*
_output_shapes
: *
N
i
initNoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign"iїЎ&Ц"     №	ц8^жAJЙХ
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
shape: *#
_output_shapes
:џџџџџџџџџ*
dtype0
l
placeholders/sampled_pos_itemsPlaceholder*
shape: *#
_output_shapes
:џџџџџџџџџ*
dtype0
l
placeholders/sampled_neg_itemsPlaceholder*
shape: *#
_output_shapes
:џџџџџџџџџ*
dtype0
q
 variables/truncated_normal/shapeConst*
valueB"  
   *
_output_shapes
:*
dtype0
d
variables/truncated_normal/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
f
!variables/truncated_normal/stddevConst*
valueB
 *шЁ>*
_output_shapes
: *
dtype0
Г
*variables/truncated_normal/TruncatedNormalTruncatedNormal variables/truncated_normal/shape*
seed2в	*
T0*
_output_shapes
:	
*
seedБџх)*
dtype0

variables/truncated_normal/mulMul*variables/truncated_normal/TruncatedNormal!variables/truncated_normal/stddev*
_output_shapes
:	
*
T0

variables/truncated_normalAddvariables/truncated_normal/mulvariables/truncated_normal/mean*
_output_shapes
:	
*
T0
s
"variables/truncated_normal_1/shapeConst*
valueB"m  
   *
_output_shapes
:*
dtype0
f
!variables/truncated_normal_1/meanConst*
valueB
 *    *
_output_shapes
: *
dtype0
h
#variables/truncated_normal_1/stddevConst*
valueB
 *шЁ>*
_output_shapes
: *
dtype0
З
,variables/truncated_normal_1/TruncatedNormalTruncatedNormal"variables/truncated_normal_1/shape*
seed2в	*
T0*
_output_shapes
:	э
*
seedБџх)*
dtype0
Є
 variables/truncated_normal_1/mulMul,variables/truncated_normal_1/TruncatedNormal#variables/truncated_normal_1/stddev*
_output_shapes
:	э
*
T0

variables/truncated_normal_1Add variables/truncated_normal_1/mul!variables/truncated_normal_1/mean*
_output_shapes
:	э
*
T0

variables/user_factors
VariableV2*
shape:	
*
shared_name *
_output_shapes
:	
*
	container *
dtype0
й
variables/user_factors/AssignAssignvariables/user_factorsvariables/truncated_normal*
use_locking(*
validate_shape(*
_output_shapes
:	
*)
_class
loc:@variables/user_factors*
T0

variables/user_factors/readIdentityvariables/user_factors*
_output_shapes
:	
*)
_class
loc:@variables/user_factors*
T0

variables/item_factors
VariableV2*
shape:	э
*
shared_name *
_output_shapes
:	э
*
	container *
dtype0
л
variables/item_factors/AssignAssignvariables/item_factorsvariables/truncated_normal_1*
use_locking(*
validate_shape(*
_output_shapes
:	э
*)
_class
loc:@variables/item_factors*
T0

variables/item_factors/readIdentityvariables/item_factors*
_output_shapes
:	э
*)
_class
loc:@variables/item_factors*
T0
^
variables/zerosConst*
valueBэ*    *
_output_shapes	
:э*
dtype0

variables/item_bias
VariableV2*
shape:э*
shared_name *
_output_shapes	
:э*
	container *
dtype0
С
variables/item_bias/AssignAssignvariables/item_biasvariables/zeros*
use_locking(*
validate_shape(*
_output_shapes	
:э*&
_class
loc:@variables/item_bias*
T0

variables/item_bias/readIdentityvariables/item_bias*
_output_shapes	
:э*&
_class
loc:@variables/item_bias*
T0
­

loss/usersGathervariables/user_factors/readplaceholders/sampled_users*
Tindices0*'
_output_shapes
:џџџџџџџџџ
*
validate_indices(*
Tparams0
Е
loss/pos_itemsGathervariables/item_factors/readplaceholders/sampled_pos_items*
Tindices0*'
_output_shapes
:џџџџџџџџџ
*
validate_indices(*
Tparams0
Е
loss/neg_itemsGathervariables/item_factors/readplaceholders/sampled_neg_items*
Tindices0*'
_output_shapes
:џџџџџџџџџ
*
validate_indices(*
Tparams0
В
loss/pos_item_biasGathervariables/item_bias/readplaceholders/sampled_pos_items*
Tindices0*#
_output_shapes
:џџџџџџџџџ*
validate_indices(*
Tparams0
В
loss/neg_item_biasGathervariables/item_bias/readplaceholders/sampled_neg_items*
Tindices0*#
_output_shapes
:џџџџџџџџџ*
validate_indices(*
Tparams0
a
loss/subSubloss/pos_itemsloss/neg_items*'
_output_shapes
:џџџџџџџџџ
*
T0
W
loss/mulMul
loss/usersloss/sub*'
_output_shapes
:џџџџџџџџџ
*
T0
\
loss/Sum/reduction_indicesConst*
value	B :*
_output_shapes
: *
dtype0

loss/SumSumloss/mulloss/Sum/reduction_indices*
	keep_dims( *

Tidx0*#
_output_shapes
:џџџџџџџџџ*
T0
g

loss/sub_1Subloss/pos_item_biasloss/neg_item_bias*#
_output_shapes
:џџџџџџџџџ*
T0
S
loss/addAdd
loss/sub_1loss/Sum*#
_output_shapes
:џџџџџџџџџ*
T0
G
loss/NegNegloss/add*#
_output_shapes
:џџџџџџџџџ*
T0
G
loss/ExpExploss/Neg*#
_output_shapes
:џџџџџџџџџ*
T0
Q
loss/add_1/xConst*
valueB
 *  ?*
_output_shapes
: *
dtype0
W

loss/add_1Addloss/add_1/xloss/Exp*#
_output_shapes
:џџџџџџџџџ*
T0
I
loss/LogLog
loss/add_1*#
_output_shapes
:џџџџџџџџџ*
T0
I

loss/Neg_1Negloss/Log*#
_output_shapes
:џџџџџџџџџ*
T0
T

loss/ConstConst*
valueB: *
_output_shapes
:*
dtype0
g

loss/Sum_1Sum
loss/Neg_1
loss/Const*
	keep_dims( *

Tidx0*
_output_shapes
: *
T0
O

loss/pow/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
Y
loss/powPow
loss/users
loss/pow/y*'
_output_shapes
:џџџџџџџџџ
*
T0
]
loss/Const_1Const*
valueB"       *
_output_shapes
:*
dtype0
g

loss/Sum_2Sumloss/powloss/Const_1*
	keep_dims( *

Tidx0*
_output_shapes
: *
T0
Q
loss/mul_1/xConst*
valueB
 *
з#<*
_output_shapes
: *
dtype0
L

loss/mul_1Mulloss/mul_1/x
loss/Sum_2*
_output_shapes
: *
T0
Q
loss/pow_1/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
a

loss/pow_1Powloss/pos_itemsloss/pow_1/y*'
_output_shapes
:џџџџџџџџџ
*
T0
]
loss/Const_2Const*
valueB"       *
_output_shapes
:*
dtype0
i

loss/Sum_3Sum
loss/pow_1loss/Const_2*
	keep_dims( *

Tidx0*
_output_shapes
: *
T0
Q
loss/mul_2/xConst*
valueB
 *
з#<*
_output_shapes
: *
dtype0
L

loss/mul_2Mulloss/mul_2/x
loss/Sum_3*
_output_shapes
: *
T0
Q
loss/pow_2/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
a

loss/pow_2Powloss/pos_item_biasloss/pow_2/y*#
_output_shapes
:џџџџџџџџџ*
T0
V
loss/Const_3Const*
valueB: *
_output_shapes
:*
dtype0
i

loss/Sum_4Sum
loss/pow_2loss/Const_3*
	keep_dims( *

Tidx0*
_output_shapes
: *
T0
J

loss/add_2Add
loss/mul_2
loss/Sum_4*
_output_shapes
: *
T0
Q
loss/pow_3/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
a

loss/pow_3Powloss/neg_itemsloss/pow_3/y*'
_output_shapes
:џџџџџџџџџ
*
T0
]
loss/Const_4Const*
valueB"       *
_output_shapes
:*
dtype0
i

loss/Sum_5Sum
loss/pow_3loss/Const_4*
	keep_dims( *

Tidx0*
_output_shapes
: *
T0
Q
loss/mul_3/xConst*
valueB
 *
з#<*
_output_shapes
: *
dtype0
L

loss/mul_3Mulloss/mul_3/x
loss/Sum_5*
_output_shapes
: *
T0
Q
loss/pow_4/yConst*
valueB
 *   @*
_output_shapes
: *
dtype0
a

loss/pow_4Powloss/neg_item_biasloss/pow_4/y*#
_output_shapes
:џџџџџџџџџ*
T0
V
loss/Const_5Const*
valueB: *
_output_shapes
:*
dtype0
i

loss/Sum_6Sum
loss/pow_4loss/Const_5*
	keep_dims( *

Tidx0*
_output_shapes
: *
T0
J

loss/add_3Add
loss/mul_3
loss/Sum_6*
_output_shapes
: *
T0
J

loss/add_4Add
loss/mul_1
loss/add_2*
_output_shapes
: *
T0
J

loss/add_5Add
loss/add_4
loss/add_3*
_output_shapes
: *
T0
J

loss/sub_2Sub
loss/add_5
loss/Sum_1*
_output_shapes
: *
T0
R
gradients/ShapeConst*
valueB *
_output_shapes
: *
dtype0
T
gradients/ConstConst*
valueB
 *  ?*
_output_shapes
: *
dtype0
Y
gradients/FillFillgradients/Shapegradients/Const*
_output_shapes
: *
T0
b
gradients/loss/sub_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/sub_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_2_grad/Shape!gradients/loss/sub_2_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Ѕ
gradients/loss/sub_2_grad/SumSumgradients/Fill/gradients/loss/sub_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0

!gradients/loss/sub_2_grad/ReshapeReshapegradients/loss/sub_2_grad/Sumgradients/loss/sub_2_grad/Shape*
Tshape0*
_output_shapes
: *
T0
Љ
gradients/loss/sub_2_grad/Sum_1Sumgradients/Fill1gradients/loss/sub_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
h
gradients/loss/sub_2_grad/NegNeggradients/loss/sub_2_grad/Sum_1*
_output_shapes
:*
T0

#gradients/loss/sub_2_grad/Reshape_1Reshapegradients/loss/sub_2_grad/Neg!gradients/loss/sub_2_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/sub_2_grad/tuple/group_depsNoOp"^gradients/loss/sub_2_grad/Reshape$^gradients/loss/sub_2_grad/Reshape_1
х
2gradients/loss/sub_2_grad/tuple/control_dependencyIdentity!gradients/loss/sub_2_grad/Reshape+^gradients/loss/sub_2_grad/tuple/group_deps*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/sub_2_grad/Reshape*
T0
ы
4gradients/loss/sub_2_grad/tuple/control_dependency_1Identity#gradients/loss/sub_2_grad/Reshape_1+^gradients/loss/sub_2_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/sub_2_grad/Reshape_1*
T0
b
gradients/loss/add_5_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/add_5_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/add_5_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_5_grad/Shape!gradients/loss/add_5_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Щ
gradients/loss/add_5_grad/SumSum2gradients/loss/sub_2_grad/tuple/control_dependency/gradients/loss/add_5_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0

!gradients/loss/add_5_grad/ReshapeReshapegradients/loss/add_5_grad/Sumgradients/loss/add_5_grad/Shape*
Tshape0*
_output_shapes
: *
T0
Э
gradients/loss/add_5_grad/Sum_1Sum2gradients/loss/sub_2_grad/tuple/control_dependency1gradients/loss/add_5_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
Ё
#gradients/loss/add_5_grad/Reshape_1Reshapegradients/loss/add_5_grad/Sum_1!gradients/loss/add_5_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/add_5_grad/tuple/group_depsNoOp"^gradients/loss/add_5_grad/Reshape$^gradients/loss/add_5_grad/Reshape_1
х
2gradients/loss/add_5_grad/tuple/control_dependencyIdentity!gradients/loss/add_5_grad/Reshape+^gradients/loss/add_5_grad/tuple/group_deps*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/add_5_grad/Reshape*
T0
ы
4gradients/loss/add_5_grad/tuple/control_dependency_1Identity#gradients/loss/add_5_grad/Reshape_1+^gradients/loss/add_5_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/add_5_grad/Reshape_1*
T0
q
'gradients/loss/Sum_1_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
О
!gradients/loss/Sum_1_grad/ReshapeReshape4gradients/loss/sub_2_grad/tuple/control_dependency_1'gradients/loss/Sum_1_grad/Reshape/shape*
Tshape0*
_output_shapes
:*
T0
i
gradients/loss/Sum_1_grad/ShapeShape
loss/Neg_1*
out_type0*
_output_shapes
:*
T0
Њ
gradients/loss/Sum_1_grad/TileTile!gradients/loss/Sum_1_grad/Reshapegradients/loss/Sum_1_grad/Shape*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ*
T0
b
gradients/loss/add_4_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/add_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/add_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_4_grad/Shape!gradients/loss/add_4_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Щ
gradients/loss/add_4_grad/SumSum2gradients/loss/add_5_grad/tuple/control_dependency/gradients/loss/add_4_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0

!gradients/loss/add_4_grad/ReshapeReshapegradients/loss/add_4_grad/Sumgradients/loss/add_4_grad/Shape*
Tshape0*
_output_shapes
: *
T0
Э
gradients/loss/add_4_grad/Sum_1Sum2gradients/loss/add_5_grad/tuple/control_dependency1gradients/loss/add_4_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
Ё
#gradients/loss/add_4_grad/Reshape_1Reshapegradients/loss/add_4_grad/Sum_1!gradients/loss/add_4_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/add_4_grad/tuple/group_depsNoOp"^gradients/loss/add_4_grad/Reshape$^gradients/loss/add_4_grad/Reshape_1
х
2gradients/loss/add_4_grad/tuple/control_dependencyIdentity!gradients/loss/add_4_grad/Reshape+^gradients/loss/add_4_grad/tuple/group_deps*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/add_4_grad/Reshape*
T0
ы
4gradients/loss/add_4_grad/tuple/control_dependency_1Identity#gradients/loss/add_4_grad/Reshape_1+^gradients/loss/add_4_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/add_4_grad/Reshape_1*
T0
b
gradients/loss/add_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/add_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/add_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_3_grad/Shape!gradients/loss/add_3_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Ы
gradients/loss/add_3_grad/SumSum4gradients/loss/add_5_grad/tuple/control_dependency_1/gradients/loss/add_3_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0

!gradients/loss/add_3_grad/ReshapeReshapegradients/loss/add_3_grad/Sumgradients/loss/add_3_grad/Shape*
Tshape0*
_output_shapes
: *
T0
Я
gradients/loss/add_3_grad/Sum_1Sum4gradients/loss/add_5_grad/tuple/control_dependency_11gradients/loss/add_3_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
Ё
#gradients/loss/add_3_grad/Reshape_1Reshapegradients/loss/add_3_grad/Sum_1!gradients/loss/add_3_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/add_3_grad/tuple/group_depsNoOp"^gradients/loss/add_3_grad/Reshape$^gradients/loss/add_3_grad/Reshape_1
х
2gradients/loss/add_3_grad/tuple/control_dependencyIdentity!gradients/loss/add_3_grad/Reshape+^gradients/loss/add_3_grad/tuple/group_deps*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/add_3_grad/Reshape*
T0
ы
4gradients/loss/add_3_grad/tuple/control_dependency_1Identity#gradients/loss/add_3_grad/Reshape_1+^gradients/loss/add_3_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/add_3_grad/Reshape_1*
T0
r
gradients/loss/Neg_1_grad/NegNeggradients/loss/Sum_1_grad/Tile*#
_output_shapes
:џџџџџџџџџ*
T0
b
gradients/loss/mul_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/mul_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_1_grad/Shape!gradients/loss/mul_1_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/mul_1_grad/mulMul2gradients/loss/add_4_grad/tuple/control_dependency
loss/Sum_2*
_output_shapes
: *
T0
Д
gradients/loss/mul_1_grad/SumSumgradients/loss/mul_1_grad/mul/gradients/loss/mul_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0

!gradients/loss/mul_1_grad/ReshapeReshapegradients/loss/mul_1_grad/Sumgradients/loss/mul_1_grad/Shape*
Tshape0*
_output_shapes
: *
T0

gradients/loss/mul_1_grad/mul_1Mulloss/mul_1/x2gradients/loss/add_4_grad/tuple/control_dependency*
_output_shapes
: *
T0
К
gradients/loss/mul_1_grad/Sum_1Sumgradients/loss/mul_1_grad/mul_11gradients/loss/mul_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
Ё
#gradients/loss/mul_1_grad/Reshape_1Reshapegradients/loss/mul_1_grad/Sum_1!gradients/loss/mul_1_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/mul_1_grad/tuple/group_depsNoOp"^gradients/loss/mul_1_grad/Reshape$^gradients/loss/mul_1_grad/Reshape_1
х
2gradients/loss/mul_1_grad/tuple/control_dependencyIdentity!gradients/loss/mul_1_grad/Reshape+^gradients/loss/mul_1_grad/tuple/group_deps*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/mul_1_grad/Reshape*
T0
ы
4gradients/loss/mul_1_grad/tuple/control_dependency_1Identity#gradients/loss/mul_1_grad/Reshape_1+^gradients/loss/mul_1_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/mul_1_grad/Reshape_1*
T0
b
gradients/loss/add_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/add_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/add_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_2_grad/Shape!gradients/loss/add_2_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Ы
gradients/loss/add_2_grad/SumSum4gradients/loss/add_4_grad/tuple/control_dependency_1/gradients/loss/add_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0

!gradients/loss/add_2_grad/ReshapeReshapegradients/loss/add_2_grad/Sumgradients/loss/add_2_grad/Shape*
Tshape0*
_output_shapes
: *
T0
Я
gradients/loss/add_2_grad/Sum_1Sum4gradients/loss/add_4_grad/tuple/control_dependency_11gradients/loss/add_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
Ё
#gradients/loss/add_2_grad/Reshape_1Reshapegradients/loss/add_2_grad/Sum_1!gradients/loss/add_2_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/add_2_grad/tuple/group_depsNoOp"^gradients/loss/add_2_grad/Reshape$^gradients/loss/add_2_grad/Reshape_1
х
2gradients/loss/add_2_grad/tuple/control_dependencyIdentity!gradients/loss/add_2_grad/Reshape+^gradients/loss/add_2_grad/tuple/group_deps*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/add_2_grad/Reshape*
T0
ы
4gradients/loss/add_2_grad/tuple/control_dependency_1Identity#gradients/loss/add_2_grad/Reshape_1+^gradients/loss/add_2_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/add_2_grad/Reshape_1*
T0
b
gradients/loss/mul_3_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/mul_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_3_grad/Shape!gradients/loss/mul_3_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/mul_3_grad/mulMul2gradients/loss/add_3_grad/tuple/control_dependency
loss/Sum_5*
_output_shapes
: *
T0
Д
gradients/loss/mul_3_grad/SumSumgradients/loss/mul_3_grad/mul/gradients/loss/mul_3_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0

!gradients/loss/mul_3_grad/ReshapeReshapegradients/loss/mul_3_grad/Sumgradients/loss/mul_3_grad/Shape*
Tshape0*
_output_shapes
: *
T0

gradients/loss/mul_3_grad/mul_1Mulloss/mul_3/x2gradients/loss/add_3_grad/tuple/control_dependency*
_output_shapes
: *
T0
К
gradients/loss/mul_3_grad/Sum_1Sumgradients/loss/mul_3_grad/mul_11gradients/loss/mul_3_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
Ё
#gradients/loss/mul_3_grad/Reshape_1Reshapegradients/loss/mul_3_grad/Sum_1!gradients/loss/mul_3_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/mul_3_grad/tuple/group_depsNoOp"^gradients/loss/mul_3_grad/Reshape$^gradients/loss/mul_3_grad/Reshape_1
х
2gradients/loss/mul_3_grad/tuple/control_dependencyIdentity!gradients/loss/mul_3_grad/Reshape+^gradients/loss/mul_3_grad/tuple/group_deps*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/mul_3_grad/Reshape*
T0
ы
4gradients/loss/mul_3_grad/tuple/control_dependency_1Identity#gradients/loss/mul_3_grad/Reshape_1+^gradients/loss/mul_3_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/mul_3_grad/Reshape_1*
T0
q
'gradients/loss/Sum_6_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
О
!gradients/loss/Sum_6_grad/ReshapeReshape4gradients/loss/add_3_grad/tuple/control_dependency_1'gradients/loss/Sum_6_grad/Reshape/shape*
Tshape0*
_output_shapes
:*
T0
i
gradients/loss/Sum_6_grad/ShapeShape
loss/pow_4*
out_type0*
_output_shapes
:*
T0
Њ
gradients/loss/Sum_6_grad/TileTile!gradients/loss/Sum_6_grad/Reshapegradients/loss/Sum_6_grad/Shape*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ*
T0

"gradients/loss/Log_grad/Reciprocal
Reciprocal
loss/add_1^gradients/loss/Neg_1_grad/Neg*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/Log_grad/mulMulgradients/loss/Neg_1_grad/Neg"gradients/loss/Log_grad/Reciprocal*#
_output_shapes
:џџџџџџџџџ*
T0
x
'gradients/loss/Sum_2_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
Т
!gradients/loss/Sum_2_grad/ReshapeReshape4gradients/loss/mul_1_grad/tuple/control_dependency_1'gradients/loss/Sum_2_grad/Reshape/shape*
Tshape0*
_output_shapes

:*
T0
g
gradients/loss/Sum_2_grad/ShapeShapeloss/pow*
out_type0*
_output_shapes
:*
T0
Ў
gradients/loss/Sum_2_grad/TileTile!gradients/loss/Sum_2_grad/Reshapegradients/loss/Sum_2_grad/Shape*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ
*
T0
b
gradients/loss/mul_2_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
d
!gradients/loss/mul_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_2_grad/Shape!gradients/loss/mul_2_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/mul_2_grad/mulMul2gradients/loss/add_2_grad/tuple/control_dependency
loss/Sum_3*
_output_shapes
: *
T0
Д
gradients/loss/mul_2_grad/SumSumgradients/loss/mul_2_grad/mul/gradients/loss/mul_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0

!gradients/loss/mul_2_grad/ReshapeReshapegradients/loss/mul_2_grad/Sumgradients/loss/mul_2_grad/Shape*
Tshape0*
_output_shapes
: *
T0

gradients/loss/mul_2_grad/mul_1Mulloss/mul_2/x2gradients/loss/add_2_grad/tuple/control_dependency*
_output_shapes
: *
T0
К
gradients/loss/mul_2_grad/Sum_1Sumgradients/loss/mul_2_grad/mul_11gradients/loss/mul_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
Ё
#gradients/loss/mul_2_grad/Reshape_1Reshapegradients/loss/mul_2_grad/Sum_1!gradients/loss/mul_2_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/mul_2_grad/tuple/group_depsNoOp"^gradients/loss/mul_2_grad/Reshape$^gradients/loss/mul_2_grad/Reshape_1
х
2gradients/loss/mul_2_grad/tuple/control_dependencyIdentity!gradients/loss/mul_2_grad/Reshape+^gradients/loss/mul_2_grad/tuple/group_deps*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/mul_2_grad/Reshape*
T0
ы
4gradients/loss/mul_2_grad/tuple/control_dependency_1Identity#gradients/loss/mul_2_grad/Reshape_1+^gradients/loss/mul_2_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/mul_2_grad/Reshape_1*
T0
q
'gradients/loss/Sum_4_grad/Reshape/shapeConst*
valueB:*
_output_shapes
:*
dtype0
О
!gradients/loss/Sum_4_grad/ReshapeReshape4gradients/loss/add_2_grad/tuple/control_dependency_1'gradients/loss/Sum_4_grad/Reshape/shape*
Tshape0*
_output_shapes
:*
T0
i
gradients/loss/Sum_4_grad/ShapeShape
loss/pow_2*
out_type0*
_output_shapes
:*
T0
Њ
gradients/loss/Sum_4_grad/TileTile!gradients/loss/Sum_4_grad/Reshapegradients/loss/Sum_4_grad/Shape*

Tmultiples0*#
_output_shapes
:џџџџџџџџџ*
T0
x
'gradients/loss/Sum_5_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
Т
!gradients/loss/Sum_5_grad/ReshapeReshape4gradients/loss/mul_3_grad/tuple/control_dependency_1'gradients/loss/Sum_5_grad/Reshape/shape*
Tshape0*
_output_shapes

:*
T0
i
gradients/loss/Sum_5_grad/ShapeShape
loss/pow_3*
out_type0*
_output_shapes
:*
T0
Ў
gradients/loss/Sum_5_grad/TileTile!gradients/loss/Sum_5_grad/Reshapegradients/loss/Sum_5_grad/Shape*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ
*
T0
q
gradients/loss/pow_4_grad/ShapeShapeloss/neg_item_bias*
out_type0*
_output_shapes
:*
T0
d
!gradients/loss/pow_4_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_4_grad/Shape!gradients/loss/pow_4_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/pow_4_grad/mulMulgradients/loss/Sum_6_grad/Tileloss/pow_4/y*#
_output_shapes
:џџџџџџџџџ*
T0
d
gradients/loss/pow_4_grad/sub/yConst*
valueB
 *  ?*
_output_shapes
: *
dtype0
t
gradients/loss/pow_4_grad/subSubloss/pow_4/ygradients/loss/pow_4_grad/sub/y*
_output_shapes
: *
T0

gradients/loss/pow_4_grad/PowPowloss/neg_item_biasgradients/loss/pow_4_grad/sub*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_4_grad/mul_1Mulgradients/loss/pow_4_grad/mulgradients/loss/pow_4_grad/Pow*#
_output_shapes
:џџџџџџџџџ*
T0
Ж
gradients/loss/pow_4_grad/SumSumgradients/loss/pow_4_grad/mul_1/gradients/loss/pow_4_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
Ј
!gradients/loss/pow_4_grad/ReshapeReshapegradients/loss/pow_4_grad/Sumgradients/loss/pow_4_grad/Shape*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
h
#gradients/loss/pow_4_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0

!gradients/loss/pow_4_grad/GreaterGreaterloss/neg_item_bias#gradients/loss/pow_4_grad/Greater/y*#
_output_shapes
:џџџџџџџџџ*
T0
f
gradients/loss/pow_4_grad/LogLogloss/neg_item_bias*#
_output_shapes
:џџџџџџџџџ*
T0
s
$gradients/loss/pow_4_grad/zeros_like	ZerosLikeloss/neg_item_bias*#
_output_shapes
:џџџџџџџџџ*
T0
Р
 gradients/loss/pow_4_grad/SelectSelect!gradients/loss/pow_4_grad/Greatergradients/loss/pow_4_grad/Log$gradients/loss/pow_4_grad/zeros_like*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_4_grad/mul_2Mulgradients/loss/Sum_6_grad/Tile
loss/pow_4*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_4_grad/mul_3Mulgradients/loss/pow_4_grad/mul_2 gradients/loss/pow_4_grad/Select*#
_output_shapes
:џџџџџџџџџ*
T0
К
gradients/loss/pow_4_grad/Sum_1Sumgradients/loss/pow_4_grad/mul_31gradients/loss/pow_4_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
Ё
#gradients/loss/pow_4_grad/Reshape_1Reshapegradients/loss/pow_4_grad/Sum_1!gradients/loss/pow_4_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/pow_4_grad/tuple/group_depsNoOp"^gradients/loss/pow_4_grad/Reshape$^gradients/loss/pow_4_grad/Reshape_1
ђ
2gradients/loss/pow_4_grad/tuple/control_dependencyIdentity!gradients/loss/pow_4_grad/Reshape+^gradients/loss/pow_4_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape*
T0
ы
4gradients/loss/pow_4_grad/tuple/control_dependency_1Identity#gradients/loss/pow_4_grad/Reshape_1+^gradients/loss/pow_4_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/pow_4_grad/Reshape_1*
T0
b
gradients/loss/add_1_grad/ShapeConst*
valueB *
_output_shapes
: *
dtype0
i
!gradients/loss/add_1_grad/Shape_1Shapeloss/Exp*
out_type0*
_output_shapes
:*
T0
Щ
/gradients/loss/add_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_1_grad/Shape!gradients/loss/add_1_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
В
gradients/loss/add_1_grad/SumSumgradients/loss/Log_grad/mul/gradients/loss/add_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0

!gradients/loss/add_1_grad/ReshapeReshapegradients/loss/add_1_grad/Sumgradients/loss/add_1_grad/Shape*
Tshape0*
_output_shapes
: *
T0
Ж
gradients/loss/add_1_grad/Sum_1Sumgradients/loss/Log_grad/mul1gradients/loss/add_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
Ў
#gradients/loss/add_1_grad/Reshape_1Reshapegradients/loss/add_1_grad/Sum_1!gradients/loss/add_1_grad/Shape_1*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
|
*gradients/loss/add_1_grad/tuple/group_depsNoOp"^gradients/loss/add_1_grad/Reshape$^gradients/loss/add_1_grad/Reshape_1
х
2gradients/loss/add_1_grad/tuple/control_dependencyIdentity!gradients/loss/add_1_grad/Reshape+^gradients/loss/add_1_grad/tuple/group_deps*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/add_1_grad/Reshape*
T0
ј
4gradients/loss/add_1_grad/tuple/control_dependency_1Identity#gradients/loss/add_1_grad/Reshape_1+^gradients/loss/add_1_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*6
_class,
*(loc:@gradients/loss/add_1_grad/Reshape_1*
T0
g
gradients/loss/pow_grad/ShapeShape
loss/users*
out_type0*
_output_shapes
:*
T0
b
gradients/loss/pow_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
У
-gradients/loss/pow_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_grad/Shapegradients/loss/pow_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/pow_grad/mulMulgradients/loss/Sum_2_grad/Tile
loss/pow/y*'
_output_shapes
:џџџџџџџџџ
*
T0
b
gradients/loss/pow_grad/sub/yConst*
valueB
 *  ?*
_output_shapes
: *
dtype0
n
gradients/loss/pow_grad/subSub
loss/pow/ygradients/loss/pow_grad/sub/y*
_output_shapes
: *
T0
}
gradients/loss/pow_grad/PowPow
loss/usersgradients/loss/pow_grad/sub*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_grad/mul_1Mulgradients/loss/pow_grad/mulgradients/loss/pow_grad/Pow*'
_output_shapes
:џџџџџџџџџ
*
T0
А
gradients/loss/pow_grad/SumSumgradients/loss/pow_grad/mul_1-gradients/loss/pow_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
І
gradients/loss/pow_grad/ReshapeReshapegradients/loss/pow_grad/Sumgradients/loss/pow_grad/Shape*
Tshape0*'
_output_shapes
:џџџџџџџџџ
*
T0
f
!gradients/loss/pow_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0

gradients/loss/pow_grad/GreaterGreater
loss/users!gradients/loss/pow_grad/Greater/y*'
_output_shapes
:џџџџџџџџџ
*
T0
`
gradients/loss/pow_grad/LogLog
loss/users*'
_output_shapes
:џџџџџџџџџ
*
T0
m
"gradients/loss/pow_grad/zeros_like	ZerosLike
loss/users*'
_output_shapes
:џџџџџџџџџ
*
T0
М
gradients/loss/pow_grad/SelectSelectgradients/loss/pow_grad/Greatergradients/loss/pow_grad/Log"gradients/loss/pow_grad/zeros_like*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_grad/mul_2Mulgradients/loss/Sum_2_grad/Tileloss/pow*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_grad/mul_3Mulgradients/loss/pow_grad/mul_2gradients/loss/pow_grad/Select*'
_output_shapes
:џџџџџџџџџ
*
T0
Д
gradients/loss/pow_grad/Sum_1Sumgradients/loss/pow_grad/mul_3/gradients/loss/pow_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0

!gradients/loss/pow_grad/Reshape_1Reshapegradients/loss/pow_grad/Sum_1gradients/loss/pow_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
v
(gradients/loss/pow_grad/tuple/group_depsNoOp ^gradients/loss/pow_grad/Reshape"^gradients/loss/pow_grad/Reshape_1
ю
0gradients/loss/pow_grad/tuple/control_dependencyIdentitygradients/loss/pow_grad/Reshape)^gradients/loss/pow_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape*
T0
у
2gradients/loss/pow_grad/tuple/control_dependency_1Identity!gradients/loss/pow_grad/Reshape_1)^gradients/loss/pow_grad/tuple/group_deps*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/pow_grad/Reshape_1*
T0
x
'gradients/loss/Sum_3_grad/Reshape/shapeConst*
valueB"      *
_output_shapes
:*
dtype0
Т
!gradients/loss/Sum_3_grad/ReshapeReshape4gradients/loss/mul_2_grad/tuple/control_dependency_1'gradients/loss/Sum_3_grad/Reshape/shape*
Tshape0*
_output_shapes

:*
T0
i
gradients/loss/Sum_3_grad/ShapeShape
loss/pow_1*
out_type0*
_output_shapes
:*
T0
Ў
gradients/loss/Sum_3_grad/TileTile!gradients/loss/Sum_3_grad/Reshapegradients/loss/Sum_3_grad/Shape*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ
*
T0
q
gradients/loss/pow_2_grad/ShapeShapeloss/pos_item_bias*
out_type0*
_output_shapes
:*
T0
d
!gradients/loss/pow_2_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_2_grad/Shape!gradients/loss/pow_2_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/pow_2_grad/mulMulgradients/loss/Sum_4_grad/Tileloss/pow_2/y*#
_output_shapes
:џџџџџџџџџ*
T0
d
gradients/loss/pow_2_grad/sub/yConst*
valueB
 *  ?*
_output_shapes
: *
dtype0
t
gradients/loss/pow_2_grad/subSubloss/pow_2/ygradients/loss/pow_2_grad/sub/y*
_output_shapes
: *
T0

gradients/loss/pow_2_grad/PowPowloss/pos_item_biasgradients/loss/pow_2_grad/sub*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_2_grad/mul_1Mulgradients/loss/pow_2_grad/mulgradients/loss/pow_2_grad/Pow*#
_output_shapes
:џџџџџџџџџ*
T0
Ж
gradients/loss/pow_2_grad/SumSumgradients/loss/pow_2_grad/mul_1/gradients/loss/pow_2_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
Ј
!gradients/loss/pow_2_grad/ReshapeReshapegradients/loss/pow_2_grad/Sumgradients/loss/pow_2_grad/Shape*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
h
#gradients/loss/pow_2_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0

!gradients/loss/pow_2_grad/GreaterGreaterloss/pos_item_bias#gradients/loss/pow_2_grad/Greater/y*#
_output_shapes
:џџџџџџџџџ*
T0
f
gradients/loss/pow_2_grad/LogLogloss/pos_item_bias*#
_output_shapes
:џџџџџџџџџ*
T0
s
$gradients/loss/pow_2_grad/zeros_like	ZerosLikeloss/pos_item_bias*#
_output_shapes
:џџџџџџџџџ*
T0
Р
 gradients/loss/pow_2_grad/SelectSelect!gradients/loss/pow_2_grad/Greatergradients/loss/pow_2_grad/Log$gradients/loss/pow_2_grad/zeros_like*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_2_grad/mul_2Mulgradients/loss/Sum_4_grad/Tile
loss/pow_2*#
_output_shapes
:џџџџџџџџџ*
T0

gradients/loss/pow_2_grad/mul_3Mulgradients/loss/pow_2_grad/mul_2 gradients/loss/pow_2_grad/Select*#
_output_shapes
:џџџџџџџџџ*
T0
К
gradients/loss/pow_2_grad/Sum_1Sumgradients/loss/pow_2_grad/mul_31gradients/loss/pow_2_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
Ё
#gradients/loss/pow_2_grad/Reshape_1Reshapegradients/loss/pow_2_grad/Sum_1!gradients/loss/pow_2_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/pow_2_grad/tuple/group_depsNoOp"^gradients/loss/pow_2_grad/Reshape$^gradients/loss/pow_2_grad/Reshape_1
ђ
2gradients/loss/pow_2_grad/tuple/control_dependencyIdentity!gradients/loss/pow_2_grad/Reshape+^gradients/loss/pow_2_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape*
T0
ы
4gradients/loss/pow_2_grad/tuple/control_dependency_1Identity#gradients/loss/pow_2_grad/Reshape_1+^gradients/loss/pow_2_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/pow_2_grad/Reshape_1*
T0
m
gradients/loss/pow_3_grad/ShapeShapeloss/neg_items*
out_type0*
_output_shapes
:*
T0
d
!gradients/loss/pow_3_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_3_grad/Shape!gradients/loss/pow_3_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/pow_3_grad/mulMulgradients/loss/Sum_5_grad/Tileloss/pow_3/y*'
_output_shapes
:џџџџџџџџџ
*
T0
d
gradients/loss/pow_3_grad/sub/yConst*
valueB
 *  ?*
_output_shapes
: *
dtype0
t
gradients/loss/pow_3_grad/subSubloss/pow_3/ygradients/loss/pow_3_grad/sub/y*
_output_shapes
: *
T0

gradients/loss/pow_3_grad/PowPowloss/neg_itemsgradients/loss/pow_3_grad/sub*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_3_grad/mul_1Mulgradients/loss/pow_3_grad/mulgradients/loss/pow_3_grad/Pow*'
_output_shapes
:џџџџџџџџџ
*
T0
Ж
gradients/loss/pow_3_grad/SumSumgradients/loss/pow_3_grad/mul_1/gradients/loss/pow_3_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
Ќ
!gradients/loss/pow_3_grad/ReshapeReshapegradients/loss/pow_3_grad/Sumgradients/loss/pow_3_grad/Shape*
Tshape0*'
_output_shapes
:џџџџџџџџџ
*
T0
h
#gradients/loss/pow_3_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0

!gradients/loss/pow_3_grad/GreaterGreaterloss/neg_items#gradients/loss/pow_3_grad/Greater/y*'
_output_shapes
:џџџџџџџџџ
*
T0
f
gradients/loss/pow_3_grad/LogLogloss/neg_items*'
_output_shapes
:џџџџџџџџџ
*
T0
s
$gradients/loss/pow_3_grad/zeros_like	ZerosLikeloss/neg_items*'
_output_shapes
:џџџџџџџџџ
*
T0
Ф
 gradients/loss/pow_3_grad/SelectSelect!gradients/loss/pow_3_grad/Greatergradients/loss/pow_3_grad/Log$gradients/loss/pow_3_grad/zeros_like*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_3_grad/mul_2Mulgradients/loss/Sum_5_grad/Tile
loss/pow_3*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_3_grad/mul_3Mulgradients/loss/pow_3_grad/mul_2 gradients/loss/pow_3_grad/Select*'
_output_shapes
:џџџџџџџџџ
*
T0
К
gradients/loss/pow_3_grad/Sum_1Sumgradients/loss/pow_3_grad/mul_31gradients/loss/pow_3_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
Ё
#gradients/loss/pow_3_grad/Reshape_1Reshapegradients/loss/pow_3_grad/Sum_1!gradients/loss/pow_3_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/pow_3_grad/tuple/group_depsNoOp"^gradients/loss/pow_3_grad/Reshape$^gradients/loss/pow_3_grad/Reshape_1
і
2gradients/loss/pow_3_grad/tuple/control_dependencyIdentity!gradients/loss/pow_3_grad/Reshape+^gradients/loss/pow_3_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape*
T0
ы
4gradients/loss/pow_3_grad/tuple/control_dependency_1Identity#gradients/loss/pow_3_grad/Reshape_1+^gradients/loss/pow_3_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/pow_3_grad/Reshape_1*
T0

gradients/loss/Exp_grad/mulMul4gradients/loss/add_1_grad/tuple/control_dependency_1loss/Exp*#
_output_shapes
:џџџџџџџџџ*
T0
m
gradients/loss/pow_1_grad/ShapeShapeloss/pos_items*
out_type0*
_output_shapes
:*
T0
d
!gradients/loss/pow_1_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
Щ
/gradients/loss/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_1_grad/Shape!gradients/loss/pow_1_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0

gradients/loss/pow_1_grad/mulMulgradients/loss/Sum_3_grad/Tileloss/pow_1/y*'
_output_shapes
:џџџџџџџџџ
*
T0
d
gradients/loss/pow_1_grad/sub/yConst*
valueB
 *  ?*
_output_shapes
: *
dtype0
t
gradients/loss/pow_1_grad/subSubloss/pow_1/ygradients/loss/pow_1_grad/sub/y*
_output_shapes
: *
T0

gradients/loss/pow_1_grad/PowPowloss/pos_itemsgradients/loss/pow_1_grad/sub*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_1_grad/mul_1Mulgradients/loss/pow_1_grad/mulgradients/loss/pow_1_grad/Pow*'
_output_shapes
:џџџџџџџџџ
*
T0
Ж
gradients/loss/pow_1_grad/SumSumgradients/loss/pow_1_grad/mul_1/gradients/loss/pow_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
Ќ
!gradients/loss/pow_1_grad/ReshapeReshapegradients/loss/pow_1_grad/Sumgradients/loss/pow_1_grad/Shape*
Tshape0*'
_output_shapes
:џџџџџџџџџ
*
T0
h
#gradients/loss/pow_1_grad/Greater/yConst*
valueB
 *    *
_output_shapes
: *
dtype0

!gradients/loss/pow_1_grad/GreaterGreaterloss/pos_items#gradients/loss/pow_1_grad/Greater/y*'
_output_shapes
:џџџџџџџџџ
*
T0
f
gradients/loss/pow_1_grad/LogLogloss/pos_items*'
_output_shapes
:џџџџџџџџџ
*
T0
s
$gradients/loss/pow_1_grad/zeros_like	ZerosLikeloss/pos_items*'
_output_shapes
:џџџџџџџџџ
*
T0
Ф
 gradients/loss/pow_1_grad/SelectSelect!gradients/loss/pow_1_grad/Greatergradients/loss/pow_1_grad/Log$gradients/loss/pow_1_grad/zeros_like*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_1_grad/mul_2Mulgradients/loss/Sum_3_grad/Tile
loss/pow_1*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/pow_1_grad/mul_3Mulgradients/loss/pow_1_grad/mul_2 gradients/loss/pow_1_grad/Select*'
_output_shapes
:џџџџџџџџџ
*
T0
К
gradients/loss/pow_1_grad/Sum_1Sumgradients/loss/pow_1_grad/mul_31gradients/loss/pow_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
Ё
#gradients/loss/pow_1_grad/Reshape_1Reshapegradients/loss/pow_1_grad/Sum_1!gradients/loss/pow_1_grad/Shape_1*
Tshape0*
_output_shapes
: *
T0
|
*gradients/loss/pow_1_grad/tuple/group_depsNoOp"^gradients/loss/pow_1_grad/Reshape$^gradients/loss/pow_1_grad/Reshape_1
і
2gradients/loss/pow_1_grad/tuple/control_dependencyIdentity!gradients/loss/pow_1_grad/Reshape+^gradients/loss/pow_1_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape*
T0
ы
4gradients/loss/pow_1_grad/tuple/control_dependency_1Identity#gradients/loss/pow_1_grad/Reshape_1+^gradients/loss/pow_1_grad/tuple/group_deps*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/pow_1_grad/Reshape_1*
T0
m
gradients/loss/Neg_grad/NegNeggradients/loss/Exp_grad/mul*#
_output_shapes
:џџџџџџџџџ*
T0
g
gradients/loss/add_grad/ShapeShape
loss/sub_1*
out_type0*
_output_shapes
:*
T0
g
gradients/loss/add_grad/Shape_1Shapeloss/Sum*
out_type0*
_output_shapes
:*
T0
У
-gradients/loss/add_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_grad/Shapegradients/loss/add_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Ў
gradients/loss/add_grad/SumSumgradients/loss/Neg_grad/Neg-gradients/loss/add_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
Ђ
gradients/loss/add_grad/ReshapeReshapegradients/loss/add_grad/Sumgradients/loss/add_grad/Shape*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
В
gradients/loss/add_grad/Sum_1Sumgradients/loss/Neg_grad/Neg/gradients/loss/add_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
Ј
!gradients/loss/add_grad/Reshape_1Reshapegradients/loss/add_grad/Sum_1gradients/loss/add_grad/Shape_1*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
v
(gradients/loss/add_grad/tuple/group_depsNoOp ^gradients/loss/add_grad/Reshape"^gradients/loss/add_grad/Reshape_1
ъ
0gradients/loss/add_grad/tuple/control_dependencyIdentitygradients/loss/add_grad/Reshape)^gradients/loss/add_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*2
_class(
&$loc:@gradients/loss/add_grad/Reshape*
T0
№
2gradients/loss/add_grad/tuple/control_dependency_1Identity!gradients/loss/add_grad/Reshape_1)^gradients/loss/add_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*4
_class*
(&loc:@gradients/loss/add_grad/Reshape_1*
T0
q
gradients/loss/sub_1_grad/ShapeShapeloss/pos_item_bias*
out_type0*
_output_shapes
:*
T0
s
!gradients/loss/sub_1_grad/Shape_1Shapeloss/neg_item_bias*
out_type0*
_output_shapes
:*
T0
Щ
/gradients/loss/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_1_grad/Shape!gradients/loss/sub_1_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Ч
gradients/loss/sub_1_grad/SumSum0gradients/loss/add_grad/tuple/control_dependency/gradients/loss/sub_1_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
Ј
!gradients/loss/sub_1_grad/ReshapeReshapegradients/loss/sub_1_grad/Sumgradients/loss/sub_1_grad/Shape*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
Ы
gradients/loss/sub_1_grad/Sum_1Sum0gradients/loss/add_grad/tuple/control_dependency1gradients/loss/sub_1_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
h
gradients/loss/sub_1_grad/NegNeggradients/loss/sub_1_grad/Sum_1*
_output_shapes
:*
T0
Ќ
#gradients/loss/sub_1_grad/Reshape_1Reshapegradients/loss/sub_1_grad/Neg!gradients/loss/sub_1_grad/Shape_1*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
|
*gradients/loss/sub_1_grad/tuple/group_depsNoOp"^gradients/loss/sub_1_grad/Reshape$^gradients/loss/sub_1_grad/Reshape_1
ђ
2gradients/loss/sub_1_grad/tuple/control_dependencyIdentity!gradients/loss/sub_1_grad/Reshape+^gradients/loss/sub_1_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*4
_class*
(&loc:@gradients/loss/sub_1_grad/Reshape*
T0
ј
4gradients/loss/sub_1_grad/tuple/control_dependency_1Identity#gradients/loss/sub_1_grad/Reshape_1+^gradients/loss/sub_1_grad/tuple/group_deps*#
_output_shapes
:џџџџџџџџџ*6
_class,
*(loc:@gradients/loss/sub_1_grad/Reshape_1*
T0
e
gradients/loss/Sum_grad/ShapeShapeloss/mul*
out_type0*
_output_shapes
:*
T0
^
gradients/loss/Sum_grad/SizeConst*
value	B :*
_output_shapes
: *
dtype0
}
gradients/loss/Sum_grad/addAddloss/Sum/reduction_indicesgradients/loss/Sum_grad/Size*
_output_shapes
: *
T0

gradients/loss/Sum_grad/modFloorModgradients/loss/Sum_grad/addgradients/loss/Sum_grad/Size*
_output_shapes
: *
T0
b
gradients/loss/Sum_grad/Shape_1Const*
valueB *
_output_shapes
: *
dtype0
e
#gradients/loss/Sum_grad/range/startConst*
value	B : *
_output_shapes
: *
dtype0
e
#gradients/loss/Sum_grad/range/deltaConst*
value	B :*
_output_shapes
: *
dtype0
Ж
gradients/loss/Sum_grad/rangeRange#gradients/loss/Sum_grad/range/startgradients/loss/Sum_grad/Size#gradients/loss/Sum_grad/range/delta*
_output_shapes
:*

Tidx0
d
"gradients/loss/Sum_grad/Fill/valueConst*
value	B :*
_output_shapes
: *
dtype0

gradients/loss/Sum_grad/FillFillgradients/loss/Sum_grad/Shape_1"gradients/loss/Sum_grad/Fill/value*
_output_shapes
: *
T0
ц
%gradients/loss/Sum_grad/DynamicStitchDynamicStitchgradients/loss/Sum_grad/rangegradients/loss/Sum_grad/modgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Fill*#
_output_shapes
:џџџџџџџџџ*
N*
T0
c
!gradients/loss/Sum_grad/Maximum/yConst*
value	B :*
_output_shapes
: *
dtype0
Ђ
gradients/loss/Sum_grad/MaximumMaximum%gradients/loss/Sum_grad/DynamicStitch!gradients/loss/Sum_grad/Maximum/y*#
_output_shapes
:џџџџџџџџџ*
T0

 gradients/loss/Sum_grad/floordivFloorDivgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Maximum*
_output_shapes
:*
T0
Ж
gradients/loss/Sum_grad/ReshapeReshape2gradients/loss/add_grad/tuple/control_dependency_1%gradients/loss/Sum_grad/DynamicStitch*
Tshape0*
_output_shapes
:*
T0
Ћ
gradients/loss/Sum_grad/TileTilegradients/loss/Sum_grad/Reshape gradients/loss/Sum_grad/floordiv*

Tmultiples0*'
_output_shapes
:џџџџџџџџџ
*
T0
ы
gradients/AddNAddN2gradients/loss/pow_2_grad/tuple/control_dependency2gradients/loss/sub_1_grad/tuple/control_dependency*#
_output_shapes
:џџџџџџџџџ*
N*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape*
T0

'gradients/loss/pos_item_bias_grad/ShapeConst*
valueB:э*
_output_shapes
:*&
_class
loc:@variables/item_bias*
dtype0

&gradients/loss/pos_item_bias_grad/SizeSizeplaceholders/sampled_pos_items*
out_type0*
_output_shapes
: *
T0
r
0gradients/loss/pos_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
Х
,gradients/loss/pos_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/pos_item_bias_grad/Size0gradients/loss/pos_item_bias_grad/ExpandDims/dim*
_output_shapes
:*

Tdim0*
T0

5gradients/loss/pos_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0

7gradients/loss/pos_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0

7gradients/loss/pos_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
Ѕ
/gradients/loss/pos_item_bias_grad/strided_sliceStridedSlice'gradients/loss/pos_item_bias_grad/Shape5gradients/loss/pos_item_bias_grad/strided_slice/stack7gradients/loss/pos_item_bias_grad/strided_slice/stack_17gradients/loss/pos_item_bias_grad/strided_slice/stack_2*
_output_shapes
: *
ellipsis_mask *

begin_mask *
shrink_axis_mask *
end_mask*
new_axis_mask *
Index0*
T0
o
-gradients/loss/pos_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ќ
(gradients/loss/pos_item_bias_grad/concatConcatV2,gradients/loss/pos_item_bias_grad/ExpandDims/gradients/loss/pos_item_bias_grad/strided_slice-gradients/loss/pos_item_bias_grad/concat/axis*

Tidx0*
_output_shapes
:*
N*
T0
Њ
)gradients/loss/pos_item_bias_grad/ReshapeReshapegradients/AddN(gradients/loss/pos_item_bias_grad/concat*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
Р
+gradients/loss/pos_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_pos_items,gradients/loss/pos_item_bias_grad/ExpandDims*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
я
gradients/AddN_1AddN2gradients/loss/pow_4_grad/tuple/control_dependency4gradients/loss/sub_1_grad/tuple/control_dependency_1*#
_output_shapes
:џџџџџџџџџ*
N*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape*
T0

'gradients/loss/neg_item_bias_grad/ShapeConst*
valueB:э*
_output_shapes
:*&
_class
loc:@variables/item_bias*
dtype0

&gradients/loss/neg_item_bias_grad/SizeSizeplaceholders/sampled_neg_items*
out_type0*
_output_shapes
: *
T0
r
0gradients/loss/neg_item_bias_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
Х
,gradients/loss/neg_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/neg_item_bias_grad/Size0gradients/loss/neg_item_bias_grad/ExpandDims/dim*
_output_shapes
:*

Tdim0*
T0

5gradients/loss/neg_item_bias_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0

7gradients/loss/neg_item_bias_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0

7gradients/loss/neg_item_bias_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
Ѕ
/gradients/loss/neg_item_bias_grad/strided_sliceStridedSlice'gradients/loss/neg_item_bias_grad/Shape5gradients/loss/neg_item_bias_grad/strided_slice/stack7gradients/loss/neg_item_bias_grad/strided_slice/stack_17gradients/loss/neg_item_bias_grad/strided_slice/stack_2*
_output_shapes
: *
ellipsis_mask *

begin_mask *
shrink_axis_mask *
end_mask*
new_axis_mask *
Index0*
T0
o
-gradients/loss/neg_item_bias_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ќ
(gradients/loss/neg_item_bias_grad/concatConcatV2,gradients/loss/neg_item_bias_grad/ExpandDims/gradients/loss/neg_item_bias_grad/strided_slice-gradients/loss/neg_item_bias_grad/concat/axis*

Tidx0*
_output_shapes
:*
N*
T0
Ќ
)gradients/loss/neg_item_bias_grad/ReshapeReshapegradients/AddN_1(gradients/loss/neg_item_bias_grad/concat*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
Р
+gradients/loss/neg_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_neg_items,gradients/loss/neg_item_bias_grad/ExpandDims*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
g
gradients/loss/mul_grad/ShapeShape
loss/users*
out_type0*
_output_shapes
:*
T0
g
gradients/loss/mul_grad/Shape_1Shapeloss/sub*
out_type0*
_output_shapes
:*
T0
У
-gradients/loss/mul_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_grad/Shapegradients/loss/mul_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
|
gradients/loss/mul_grad/mulMulgradients/loss/Sum_grad/Tileloss/sub*'
_output_shapes
:џџџџџџџџџ
*
T0
Ў
gradients/loss/mul_grad/SumSumgradients/loss/mul_grad/mul-gradients/loss/mul_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
І
gradients/loss/mul_grad/ReshapeReshapegradients/loss/mul_grad/Sumgradients/loss/mul_grad/Shape*
Tshape0*'
_output_shapes
:џџџџџџџџџ
*
T0

gradients/loss/mul_grad/mul_1Mul
loss/usersgradients/loss/Sum_grad/Tile*'
_output_shapes
:џџџџџџџџџ
*
T0
Д
gradients/loss/mul_grad/Sum_1Sumgradients/loss/mul_grad/mul_1/gradients/loss/mul_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
Ќ
!gradients/loss/mul_grad/Reshape_1Reshapegradients/loss/mul_grad/Sum_1gradients/loss/mul_grad/Shape_1*
Tshape0*'
_output_shapes
:џџџџџџџџџ
*
T0
v
(gradients/loss/mul_grad/tuple/group_depsNoOp ^gradients/loss/mul_grad/Reshape"^gradients/loss/mul_grad/Reshape_1
ю
0gradients/loss/mul_grad/tuple/control_dependencyIdentitygradients/loss/mul_grad/Reshape)^gradients/loss/mul_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*2
_class(
&$loc:@gradients/loss/mul_grad/Reshape*
T0
є
2gradients/loss/mul_grad/tuple/control_dependency_1Identity!gradients/loss/mul_grad/Reshape_1)^gradients/loss/mul_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*4
_class*
(&loc:@gradients/loss/mul_grad/Reshape_1*
T0
W
gradients/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
Ь
gradients/concatConcatV2)gradients/loss/pos_item_bias_grad/Reshape)gradients/loss/neg_item_bias_grad/Reshapegradients/concat/axis*

Tidx0*#
_output_shapes
:џџџџџџџџџ*
N*
T0
Y
gradients/concat_1/axisConst*
value	B : *
_output_shapes
: *
dtype0
д
gradients/concat_1ConcatV2+gradients/loss/pos_item_bias_grad/Reshape_1+gradients/loss/neg_item_bias_grad/Reshape_1gradients/concat_1/axis*

Tidx0*#
_output_shapes
:џџџџџџџџџ*
N*
T0
ы
gradients/AddN_2AddN0gradients/loss/pow_grad/tuple/control_dependency0gradients/loss/mul_grad/tuple/control_dependency*'
_output_shapes
:џџџџџџџџџ
*
N*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape*
T0

gradients/loss/users_grad/ShapeConst*
valueB"  
   *
_output_shapes
:*)
_class
loc:@variables/user_factors*
dtype0
s
gradients/loss/users_grad/SizeSizeplaceholders/sampled_users*
out_type0*
_output_shapes
: *
T0
j
(gradients/loss/users_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
­
$gradients/loss/users_grad/ExpandDims
ExpandDimsgradients/loss/users_grad/Size(gradients/loss/users_grad/ExpandDims/dim*
_output_shapes
:*

Tdim0*
T0
w
-gradients/loss/users_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
y
/gradients/loss/users_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
y
/gradients/loss/users_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0
џ
'gradients/loss/users_grad/strided_sliceStridedSlicegradients/loss/users_grad/Shape-gradients/loss/users_grad/strided_slice/stack/gradients/loss/users_grad/strided_slice/stack_1/gradients/loss/users_grad/strided_slice/stack_2*
_output_shapes
:*
ellipsis_mask *

begin_mask *
shrink_axis_mask *
end_mask*
new_axis_mask *
Index0*
T0
g
%gradients/loss/users_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
м
 gradients/loss/users_grad/concatConcatV2$gradients/loss/users_grad/ExpandDims'gradients/loss/users_grad/strided_slice%gradients/loss/users_grad/concat/axis*

Tidx0*
_output_shapes
:*
N*
T0
Љ
!gradients/loss/users_grad/ReshapeReshapegradients/AddN_2 gradients/loss/users_grad/concat*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
T0
Ќ
#gradients/loss/users_grad/Reshape_1Reshapeplaceholders/sampled_users$gradients/loss/users_grad/ExpandDims*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
k
gradients/loss/sub_grad/ShapeShapeloss/pos_items*
out_type0*
_output_shapes
:*
T0
m
gradients/loss/sub_grad/Shape_1Shapeloss/neg_items*
out_type0*
_output_shapes
:*
T0
У
-gradients/loss/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_grad/Shapegradients/loss/sub_grad/Shape_1*2
_output_shapes 
:џџџџџџџџџ:џџџџџџџџџ*
T0
Х
gradients/loss/sub_grad/SumSum2gradients/loss/mul_grad/tuple/control_dependency_1-gradients/loss/sub_grad/BroadcastGradientArgs*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
І
gradients/loss/sub_grad/ReshapeReshapegradients/loss/sub_grad/Sumgradients/loss/sub_grad/Shape*
Tshape0*'
_output_shapes
:џџџџџџџџџ
*
T0
Щ
gradients/loss/sub_grad/Sum_1Sum2gradients/loss/mul_grad/tuple/control_dependency_1/gradients/loss/sub_grad/BroadcastGradientArgs:1*
	keep_dims( *

Tidx0*
_output_shapes
:*
T0
d
gradients/loss/sub_grad/NegNeggradients/loss/sub_grad/Sum_1*
_output_shapes
:*
T0
Њ
!gradients/loss/sub_grad/Reshape_1Reshapegradients/loss/sub_grad/Neggradients/loss/sub_grad/Shape_1*
Tshape0*'
_output_shapes
:џџџџџџџџџ
*
T0
v
(gradients/loss/sub_grad/tuple/group_depsNoOp ^gradients/loss/sub_grad/Reshape"^gradients/loss/sub_grad/Reshape_1
ю
0gradients/loss/sub_grad/tuple/control_dependencyIdentitygradients/loss/sub_grad/Reshape)^gradients/loss/sub_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*2
_class(
&$loc:@gradients/loss/sub_grad/Reshape*
T0
є
2gradients/loss/sub_grad/tuple/control_dependency_1Identity!gradients/loss/sub_grad/Reshape_1)^gradients/loss/sub_grad/tuple/group_deps*'
_output_shapes
:џџџџџџџџџ
*4
_class*
(&loc:@gradients/loss/sub_grad/Reshape_1*
T0
я
gradients/AddN_3AddN2gradients/loss/pow_1_grad/tuple/control_dependency0gradients/loss/sub_grad/tuple/control_dependency*'
_output_shapes
:џџџџџџџџџ
*
N*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape*
T0

#gradients/loss/pos_items_grad/ShapeConst*
valueB"m  
   *
_output_shapes
:*)
_class
loc:@variables/item_factors*
dtype0
{
"gradients/loss/pos_items_grad/SizeSizeplaceholders/sampled_pos_items*
out_type0*
_output_shapes
: *
T0
n
,gradients/loss/pos_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
Й
(gradients/loss/pos_items_grad/ExpandDims
ExpandDims"gradients/loss/pos_items_grad/Size,gradients/loss/pos_items_grad/ExpandDims/dim*
_output_shapes
:*

Tdim0*
T0
{
1gradients/loss/pos_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
}
3gradients/loss/pos_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
}
3gradients/loss/pos_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0

+gradients/loss/pos_items_grad/strided_sliceStridedSlice#gradients/loss/pos_items_grad/Shape1gradients/loss/pos_items_grad/strided_slice/stack3gradients/loss/pos_items_grad/strided_slice/stack_13gradients/loss/pos_items_grad/strided_slice/stack_2*
_output_shapes
:*
ellipsis_mask *

begin_mask *
shrink_axis_mask *
end_mask*
new_axis_mask *
Index0*
T0
k
)gradients/loss/pos_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
$gradients/loss/pos_items_grad/concatConcatV2(gradients/loss/pos_items_grad/ExpandDims+gradients/loss/pos_items_grad/strided_slice)gradients/loss/pos_items_grad/concat/axis*

Tidx0*
_output_shapes
:*
N*
T0
Б
%gradients/loss/pos_items_grad/ReshapeReshapegradients/AddN_3$gradients/loss/pos_items_grad/concat*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
T0
И
'gradients/loss/pos_items_grad/Reshape_1Reshapeplaceholders/sampled_pos_items(gradients/loss/pos_items_grad/ExpandDims*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
ё
gradients/AddN_4AddN2gradients/loss/pow_3_grad/tuple/control_dependency2gradients/loss/sub_grad/tuple/control_dependency_1*'
_output_shapes
:џџџџџџџџџ
*
N*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape*
T0

#gradients/loss/neg_items_grad/ShapeConst*
valueB"m  
   *
_output_shapes
:*)
_class
loc:@variables/item_factors*
dtype0
{
"gradients/loss/neg_items_grad/SizeSizeplaceholders/sampled_neg_items*
out_type0*
_output_shapes
: *
T0
n
,gradients/loss/neg_items_grad/ExpandDims/dimConst*
value	B : *
_output_shapes
: *
dtype0
Й
(gradients/loss/neg_items_grad/ExpandDims
ExpandDims"gradients/loss/neg_items_grad/Size,gradients/loss/neg_items_grad/ExpandDims/dim*
_output_shapes
:*

Tdim0*
T0
{
1gradients/loss/neg_items_grad/strided_slice/stackConst*
valueB:*
_output_shapes
:*
dtype0
}
3gradients/loss/neg_items_grad/strided_slice/stack_1Const*
valueB: *
_output_shapes
:*
dtype0
}
3gradients/loss/neg_items_grad/strided_slice/stack_2Const*
valueB:*
_output_shapes
:*
dtype0

+gradients/loss/neg_items_grad/strided_sliceStridedSlice#gradients/loss/neg_items_grad/Shape1gradients/loss/neg_items_grad/strided_slice/stack3gradients/loss/neg_items_grad/strided_slice/stack_13gradients/loss/neg_items_grad/strided_slice/stack_2*
_output_shapes
:*
ellipsis_mask *

begin_mask *
shrink_axis_mask *
end_mask*
new_axis_mask *
Index0*
T0
k
)gradients/loss/neg_items_grad/concat/axisConst*
value	B : *
_output_shapes
: *
dtype0
ь
$gradients/loss/neg_items_grad/concatConcatV2(gradients/loss/neg_items_grad/ExpandDims+gradients/loss/neg_items_grad/strided_slice)gradients/loss/neg_items_grad/concat/axis*

Tidx0*
_output_shapes
:*
N*
T0
Б
%gradients/loss/neg_items_grad/ReshapeReshapegradients/AddN_4$gradients/loss/neg_items_grad/concat*
Tshape0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
T0
И
'gradients/loss/neg_items_grad/Reshape_1Reshapeplaceholders/sampled_neg_items(gradients/loss/neg_items_grad/ExpandDims*
Tshape0*#
_output_shapes
:џџџџџџџџџ*
T0
Y
gradients/concat_2/axisConst*
value	B : *
_output_shapes
: *
dtype0
е
gradients/concat_2ConcatV2%gradients/loss/pos_items_grad/Reshape%gradients/loss/neg_items_grad/Reshapegradients/concat_2/axis*

Tidx0*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*
N*
T0
Y
gradients/concat_3/axisConst*
value	B : *
_output_shapes
: *
dtype0
Ь
gradients/concat_3ConcatV2'gradients/loss/pos_items_grad/Reshape_1'gradients/loss/neg_items_grad/Reshape_1gradients/concat_3/axis*

Tidx0*#
_output_shapes
:џџџџџџџџџ*
N*
T0
b
GradientDescent/learning_rateConst*
valueB
 *ЭЬЬ=*
_output_shapes
: *
dtype0
р
1GradientDescent/update_variables/user_factors/mulMul!gradients/loss/users_grad/ReshapeGradientDescent/learning_rate*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*)
_class
loc:@variables/user_factors*
T0
Ў
8GradientDescent/update_variables/user_factors/ScatterSub
ScatterSubvariables/user_factors#gradients/loss/users_grad/Reshape_11GradientDescent/update_variables/user_factors/mul*
use_locking( *
_output_shapes
:	
*)
_class
loc:@variables/user_factors*
Tindices0*
T0
б
1GradientDescent/update_variables/item_factors/mulMulgradients/concat_2GradientDescent/learning_rate*0
_output_shapes
:џџџџџџџџџџџџџџџџџџ*)
_class
loc:@variables/item_factors*
T0

8GradientDescent/update_variables/item_factors/ScatterSub
ScatterSubvariables/item_factorsgradients/concat_31GradientDescent/update_variables/item_factors/mul*
use_locking( *
_output_shapes
:	э
*)
_class
loc:@variables/item_factors*
Tindices0*
T0
М
.GradientDescent/update_variables/item_bias/mulMulgradients/concatGradientDescent/learning_rate*#
_output_shapes
:џџџџџџџџџ*&
_class
loc:@variables/item_bias*
T0

5GradientDescent/update_variables/item_bias/ScatterSub
ScatterSubvariables/item_biasgradients/concat_1.GradientDescent/update_variables/item_bias/mul*
use_locking( *
_output_shapes	
:э*&
_class
loc:@variables/item_bias*
Tindices0*
T0
Х
GradientDescentNoOp9^GradientDescent/update_variables/user_factors/ScatterSub9^GradientDescent/update_variables/item_factors/ScatterSub6^GradientDescent/update_variables/item_bias/ScatterSub
R
loss_1/tagsConst*
valueB Bloss_1*
_output_shapes
: *
dtype0
Q
loss_1ScalarSummaryloss_1/tags
loss/sub_2*
_output_shapes
: *
T0
K
Merge/MergeSummaryMergeSummaryloss_1*
_output_shapes
: *
N
i
initNoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign"" 
trainable_variables
X
variables/user_factors:0variables/user_factors/Assignvariables/user_factors/read:0
X
variables/item_factors:0variables/item_factors/Assignvariables/item_factors/read:0
O
variables/item_bias:0variables/item_bias/Assignvariables/item_bias/read:0"
train_op

GradientDescent"
	variables
X
variables/user_factors:0variables/user_factors/Assignvariables/user_factors/read:0
X
variables/item_factors:0variables/item_factors/Assignvariables/item_factors/read:0
O
variables/item_bias:0variables/item_bias/Assignvariables/item_bias/read:0"
	summaries


loss_1:08БВM       и-	8^жA*

loss_1>Cъo5ц       ШС	s8^жA*

loss_1ђЈCФH       ШС	Qі8^жA*

loss_1і­CU>Љ       ШС	Я8^жA*

loss_1qРCў.ё       ШС	Ё8^жA*

loss_1 P
CеBф       ШС	s8^жA*

loss_1ГИCШЋЙ       ШС	,J8^жA*

loss_1#	C#"       ШС	Й8^жA*

loss_1CvЦБ       ШС	Wш8^жA*

loss_1щюCзњ3       ШС	Мъ8^жA	*

loss_1UC[ъ       ШС	Йп8^жA
*

loss_1ЊC<Л&+       ШС	НТ8^жA*

loss_1ўхCА7       ШС	Џ8^жA*

loss_1NV	C?f       ШС	№8^жA*

loss_1FxC?1 а       ШС	ћY8^жA*

loss_1њм
CЏКс       ШС	|B8^жA*

loss_1@CчЦt5       ШС	%8^жA*

loss_1W"CЏ       ШС	8^жA*

loss_1а№CиК       ШС	D§8^жA*

loss_13јC$Ј \       ШС	њђ8^жA*

loss_1/О CпkJL       ШС	Нп 8^жA*

loss_1C~P?К       ШС	@П!8^жA*

loss_1Ы-ўBЕVЏ       ШС	Ь"8^жA*

loss_1иЛCfэ       ШС	j#8^жA*

loss_1тЗCLЕа;       ШС	ц<$8^жA*

loss_1vCёЛгO       ШС	 4%8^жA*

loss_1ВВўBвfq       ШС	Е&8^жA*

loss_1Zж Cu$І       ШС	!'8^жA*

loss_1П_ќBQ	rW       ШС	 е'8^жA*

loss_1g" CXЋH       ШС	БЄ(8^жA*

loss_1њџBd       ШС	Щr)8^жA*

loss_1ЉџB-m       ШС	^J*8^жA*

loss_1~{ CЫlгЩ       ШС	6+8^жA *

loss_1Г'ўB[       ШС	Ј,8^жA!*

loss_1Р§B8"9       ШС	§,8^жA"*

loss_1Х2џB]q       ШС	и-8^жA#*

loss_1Љи§B!З4       ШС	єЉ.8^жA$*

loss_1EѓB[Щ6§       ШС	ђ|/8^жA%*

loss_1~юїBV       ШС	4J08^жA&*

loss_1­ђBUб*7       ШС	18^жA'*

loss_1ЈfюB^$Г       ШС	ы18^жA(*

loss_1№Ј№BСW       ШС	ьћ28^жA)*

loss_1юBэйA1       ШС	љм38^жA**

loss_1ќvіBжAК&       ШС	 В48^жA+*

loss_1O	юBr^Zq       ШС	58^жA,*

loss_1ZчB:ё@       ШС	Q68^жA-*

loss_1ЏшBWяx       ШС	щ*78^жA.*

loss_1"ќьBќj*,       ШС	Х88^жA/*

loss_1ВЅэB~bЯ       ШС	)ч88^жA0*

loss_1ДтB_ВЧЊ       ШС	Щ:8^жA1*

loss_1ќцBЎy       ШС	w;8^жA2*

loss_1пmфBёЈ       ШС	ъw<8^жA3*

loss_1ЗѓчBЈ-        ШС	=8^жA4*

loss_1цB0s       ШС	ђy>8^жA5*

loss_1{нBФАКй       ШС	YQ?8^жA6*

loss_1 нBАT       ШС	?@8^жA7*

loss_1$оBzге       ШС	5A8^жA8*

loss_1ќсBјм       ШС	 рA8^жA9*

loss_1џййBbОaљ       ШС	ДB8^жA:*

loss_1бBЉ9л       ШС	3C8^жA;*

loss_1КZкBJ?э       ШС	|`D8^жA<*

loss_1іНнBUI|D       ШС	Ц3E8^жA=*

loss_1}фB_5ин       ШС	GF8^жA>*

loss_1кBRеL2       ШС	BвF8^жA?*

loss_1VVгB;мс       ШС	ЭG8^жA@*

loss_1lwзB+rx       ШС	xЕH8^жAA*

loss_1sмBZ !       ШС	АI8^жAB*

loss_1дBр=SF       ШС	cbJ8^жAC*

loss_1ьпЭBВ"ЊЕ       ШС		5K8^жAD*

loss_1§цЮBo7|u       ШС	тL8^жAE*

loss_1КюЪB<іm       ШС	SъL8^жAF*

loss_1 jиB1pиС       ШС	јХM8^жAG*

loss_1ёХBфU       ШС	"ЧN8^жAH*

loss_1ШЖШBеc#3       ШС	­O8^жAI*

loss_1rCШBСёУ       ШС	P8^жAJ*

loss_1Э~ЩBz       ШС	k`Q8^жAK*

loss_1ИИB§иU       ШС	6R8^жAL*

loss_1_мФBфУIЯ       ШС		S8^жAM*

loss_1SзЦBњъ       ШС	ѕзS8^жAN*

loss_1О НBсЪ'       ШС	ЋT8^жAO*

loss_1в)ЫBb
       ШС	Z U8^жAP*

loss_1ї/ЫB^       ШС	VV8^жAQ*

loss_15ЉМBфoх       ШС	QOW8^жAR*

loss_1њРОBаћ       ШС	.X8^жAS*

loss_1<гБBrЙ#       ШС	АY8^жAT*

loss_1ГяПBІ       ШС	QмY8^жAU*

loss_1-ЧТBЊиХ       ШС	НZ8^жAV*

loss_1ё1МBZРЙ       ШС	[8^жAW*

loss_1rмАBЃXw       ШС	t}\8^жAX*

loss_1yА­BС]       ШС	Ѓs]8^жAY*

loss_1rіЙBЄъ       ШС	ЁI^8^жAZ*

loss_1ЕB.EЮX       ШС	о_8^жA[*

loss_1НHЎB=дяЪ       ШС	Ђ`8^жA\*

loss_1cИBN.У       ШС	gю`8^жA]*

loss_1ДАBёkчY       ШС	еa8^жA^*

loss_1N!ЃB~квж       ШС	vСb8^жA_*

loss_1Д BAыn       ШС	ЃЫc8^жA`*

loss_1r)ЃB&Wїj       ШС	юБd8^жAa*

loss_1*HЈBKвЉ       ШС	DЃe8^жAb*

loss_1ШЈBTеЭT       ШС	f8^жAc*

loss_1цЗBЏ_F<       ШС	сbg8^жAd*

loss_1ЈЋЅBsI       ШС	НQh8^жAe*

loss_1ќ+ЁBZРЕ       ШС	$i8^жAf*

loss_1ЕАЄBЊ0№Я       ШС	њ*j8^жAg*

loss_1ууЈB;уХж       ШС	њ'k8^жAh*

loss_1 BЊ9       ШС	l8^жAi*

loss_1ЪHBЇЬжK       ШС	cьl8^жAj*

loss_1ёЁBЊFуІ       ШС	уЧm8^жAk*

loss_1ЬяІBt*       ШС	Љn8^жAl*

loss_1}y BЉO4       ШС	Co8^жAm*

loss_1qUBJЌ       ШС	еp8^жAn*

loss_1CB%чH       ШС	}q8^жAo*

loss_1Ћў BЯc       ШС	kr8^жAp*

loss_1і
B0В       ШС	xЗs8^жAq*

loss_1ђЌЃB'о.       ШС	ИЌt8^жAr*

loss_1akBеюТ       ШС	­u8^жAs*

loss_1їB4xз       ШС	Lv8^жAt*

loss_1ДиBхsaо       ШС	lw8^жAu*

loss_1Ќ%B>ёZ       ШС	+Lx8^жAv*

loss_1[КB|Дm       ШС	чy8^жAw*

loss_1ЧЫ BрoZ       ШС	Цz8^жAx*

loss_1,лB*-O       ШС	к {8^жAy*

loss_1(BФ}	н       ШС	эи{8^жAz*

loss_1jБBЙЋ       ШС	МЏ|8^жA{*

loss_1OlBёл9       ШС	}8^жA|*

loss_1ИЭBlў       ШС	Su~8^жA}*

loss_1Bpэjъ       ШС	_^8^жA~*

loss_1vB"Іѓ       ШС	cG8^жA*

loss_1БB*zШ       `/п#	ч:8^жA*

loss_1уIBу&7       `/п#	а'8^жA*

loss_1|3Bљ9р.       `/п#	8^жA*

loss_1PB-i5z       `/п#	я8^жA*

loss_1I[BИ6џ
       `/п#	Ћа8^жA*

loss_1BL:       `/п#	ќЋ8^жA*

loss_1бB№NU       `/п#	)8^жA*

loss_1ФSBЭD       `/п#	бv8^жA*

loss_1_пBѓЕЁЇ       `/п#	x`8^жA*

loss_18ЌBЂЧзв       `/п#	58^жA*

loss_1rжB8Кwr       `/п#	48^жA*

loss_18B3q       `/п#	Ї"8^жA*

loss_1BЙFщP       `/п#	8^жA*

loss_1ЦBЇь       `/п#	с8^жA*

loss_1QЇBgсz       `/п#	6Ь8^жA*

loss_1Ѓ5BEэ       `/п#	Лв8^жA*

loss_1WrBС9ї       `/п#	м8^жA*

loss_1ШB.Јкl       `/п#	8^жA*

loss_1Юp|BX@/       `/п#	eф8^жA*

loss_1XаwBЬоH       `/п#	Й8^жA*

loss_13BтЕr       `/п#	8^жA*

loss_1№ИBKтэь       `/п#	!\8^жA*

loss_1ЂB~HўП