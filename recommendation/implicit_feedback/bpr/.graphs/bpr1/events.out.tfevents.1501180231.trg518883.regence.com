       �K"	  �Q�^�Abrain.Event:2�p�B     N��	s�Q�^�A"��
e
placeholders/sampled_usersPlaceholder*
dtype0*
_output_shapes	
:�*
shape:�
i
placeholders/sampled_pos_itemsPlaceholder*
dtype0*
_output_shapes	
:�*
shape:�
i
placeholders/sampled_neg_itemsPlaceholder*
dtype0*
_output_shapes	
:�*
shape:�
q
 variables/truncated_normal/shapeConst*
_output_shapes
:*
dtype0*
valueB"  
   
d
variables/truncated_normal/meanConst*
_output_shapes
: *
dtype0*
valueB
 *    
f
!variables/truncated_normal/stddevConst*
_output_shapes
: *
dtype0*
valueB
 *��>
�
*variables/truncated_normal/TruncatedNormalTruncatedNormal variables/truncated_normal/shape*
T0*
_output_shapes
:	�
*
dtype0*
seed���)*
seed2�	
�
variables/truncated_normal/mulMul*variables/truncated_normal/TruncatedNormal!variables/truncated_normal/stddev*
T0*
_output_shapes
:	�

�
variables/truncated_normalAddvariables/truncated_normal/mulvariables/truncated_normal/mean*
T0*
_output_shapes
:	�

s
"variables/truncated_normal_1/shapeConst*
_output_shapes
:*
dtype0*
valueB"m  
   
f
!variables/truncated_normal_1/meanConst*
_output_shapes
: *
dtype0*
valueB
 *    
h
#variables/truncated_normal_1/stddevConst*
_output_shapes
: *
dtype0*
valueB
 *��>
�
,variables/truncated_normal_1/TruncatedNormalTruncatedNormal"variables/truncated_normal_1/shape*
T0*
_output_shapes
:	�
*
dtype0*
seed���)*
seed2�	
�
 variables/truncated_normal_1/mulMul,variables/truncated_normal_1/TruncatedNormal#variables/truncated_normal_1/stddev*
T0*
_output_shapes
:	�

�
variables/truncated_normal_1Add variables/truncated_normal_1/mul!variables/truncated_normal_1/mean*
T0*
_output_shapes
:	�

�
variables/user_factors
VariableV2*
_output_shapes
:	�
*
dtype0*
	container *
shape:	�
*
shared_name 
�
variables/user_factors/AssignAssignvariables/user_factorsvariables/truncated_normal*
T0*
_output_shapes
:	�
*
use_locking(*)
_class
loc:@variables/user_factors*
validate_shape(
�
variables/user_factors/readIdentityvariables/user_factors*
T0*
_output_shapes
:	�
*)
_class
loc:@variables/user_factors
�
variables/item_factors
VariableV2*
_output_shapes
:	�
*
dtype0*
	container *
shape:	�
*
shared_name 
�
variables/item_factors/AssignAssignvariables/item_factorsvariables/truncated_normal_1*
T0*
_output_shapes
:	�
*
use_locking(*)
_class
loc:@variables/item_factors*
validate_shape(
�
variables/item_factors/readIdentityvariables/item_factors*
T0*
_output_shapes
:	�
*)
_class
loc:@variables/item_factors
^
variables/zerosConst*
_output_shapes	
:�*
dtype0*
valueB�*    
�
variables/item_bias
VariableV2*
_output_shapes	
:�*
dtype0*
	container *
shape:�*
shared_name 
�
variables/item_bias/AssignAssignvariables/item_biasvariables/zeros*
T0*
_output_shapes	
:�*
use_locking(*&
_class
loc:@variables/item_bias*
validate_shape(
�
variables/item_bias/readIdentityvariables/item_bias*
T0*
_output_shapes	
:�*&
_class
loc:@variables/item_bias
�

loss/usersGathervariables/user_factors/readplaceholders/sampled_users*
_output_shapes
:	�
*
Tparams0*
validate_indices(*
Tindices0
�
loss/pos_itemsGathervariables/item_factors/readplaceholders/sampled_pos_items*
_output_shapes
:	�
*
Tparams0*
validate_indices(*
Tindices0
�
loss/neg_itemsGathervariables/item_factors/readplaceholders/sampled_neg_items*
_output_shapes
:	�
*
Tparams0*
validate_indices(*
Tindices0
�
loss/pos_item_biasGathervariables/item_bias/readplaceholders/sampled_pos_items*
_output_shapes	
:�*
Tparams0*
validate_indices(*
Tindices0
�
loss/neg_item_biasGathervariables/item_bias/readplaceholders/sampled_neg_items*
_output_shapes	
:�*
Tparams0*
validate_indices(*
Tindices0
Y
loss/subSubloss/pos_itemsloss/neg_items*
T0*
_output_shapes
:	�

O
loss/mulMul
loss/usersloss/sub*
T0*
_output_shapes
:	�

\
loss/Sum/reduction_indicesConst*
_output_shapes
: *
dtype0*
value	B :
x
loss/SumSumloss/mulloss/Sum/reduction_indices*
T0*

Tidx0*
_output_shapes	
:�*
	keep_dims( 
_

loss/sub_1Subloss/pos_item_biasloss/neg_item_bias*
T0*
_output_shapes	
:�
K
loss/addAdd
loss/sub_1loss/Sum*
T0*
_output_shapes	
:�
?
loss/NegNegloss/add*
T0*
_output_shapes	
:�
?
loss/ExpExploss/Neg*
T0*
_output_shapes	
:�
Q
loss/add_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
O

loss/add_1Addloss/add_1/xloss/Exp*
T0*
_output_shapes	
:�
A
loss/LogLog
loss/add_1*
T0*
_output_shapes	
:�
A

loss/Neg_1Negloss/Log*
T0*
_output_shapes	
:�
T

loss/ConstConst*
_output_shapes
:*
dtype0*
valueB: 
g

loss/Sum_1Sum
loss/Neg_1
loss/Const*
T0*

Tidx0*
_output_shapes
: *
	keep_dims( 
O

loss/pow/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
Q
loss/powPow
loss/users
loss/pow/y*
T0*
_output_shapes
:	�

]
loss/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       
g

loss/Sum_2Sumloss/powloss/Const_1*
T0*

Tidx0*
_output_shapes
: *
	keep_dims( 
Q
loss/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<
L

loss/mul_1Mulloss/mul_1/x
loss/Sum_2*
T0*
_output_shapes
: 
Q
loss/pow_1/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
Y

loss/pow_1Powloss/pos_itemsloss/pow_1/y*
T0*
_output_shapes
:	�

]
loss/Const_2Const*
_output_shapes
:*
dtype0*
valueB"       
i

loss/Sum_3Sum
loss/pow_1loss/Const_2*
T0*

Tidx0*
_output_shapes
: *
	keep_dims( 
Q
loss/mul_2/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<
L

loss/mul_2Mulloss/mul_2/x
loss/Sum_3*
T0*
_output_shapes
: 
Q
loss/pow_2/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
Y

loss/pow_2Powloss/pos_item_biasloss/pow_2/y*
T0*
_output_shapes	
:�
V
loss/Const_3Const*
_output_shapes
:*
dtype0*
valueB: 
i

loss/Sum_4Sum
loss/pow_2loss/Const_3*
T0*

Tidx0*
_output_shapes
: *
	keep_dims( 
J

loss/add_2Add
loss/mul_2
loss/Sum_4*
T0*
_output_shapes
: 
Q
loss/pow_3/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
Y

loss/pow_3Powloss/neg_itemsloss/pow_3/y*
T0*
_output_shapes
:	�

]
loss/Const_4Const*
_output_shapes
:*
dtype0*
valueB"       
i

loss/Sum_5Sum
loss/pow_3loss/Const_4*
T0*

Tidx0*
_output_shapes
: *
	keep_dims( 
Q
loss/mul_3/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<
L

loss/mul_3Mulloss/mul_3/x
loss/Sum_5*
T0*
_output_shapes
: 
Q
loss/pow_4/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
Y

loss/pow_4Powloss/neg_item_biasloss/pow_4/y*
T0*
_output_shapes	
:�
V
loss/Const_5Const*
_output_shapes
:*
dtype0*
valueB: 
i

loss/Sum_6Sum
loss/pow_4loss/Const_5*
T0*

Tidx0*
_output_shapes
: *
	keep_dims( 
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
gradients/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
T
gradients/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
Y
gradients/FillFillgradients/Shapegradients/Const*
T0*
_output_shapes
: 
b
gradients/loss/sub_2_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/sub_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_2_grad/Shape!gradients/loss/sub_2_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/sub_2_grad/SumSumgradients/Fill/gradients/loss/sub_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/sub_2_grad/ReshapeReshapegradients/loss/sub_2_grad/Sumgradients/loss/sub_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
�
gradients/loss/sub_2_grad/Sum_1Sumgradients/Fill1gradients/loss/sub_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
h
gradients/loss/sub_2_grad/NegNeggradients/loss/sub_2_grad/Sum_1*
T0*
_output_shapes
:
�
#gradients/loss/sub_2_grad/Reshape_1Reshapegradients/loss/sub_2_grad/Neg!gradients/loss/sub_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/sub_2_grad/tuple/group_depsNoOp"^gradients/loss/sub_2_grad/Reshape$^gradients/loss/sub_2_grad/Reshape_1
�
2gradients/loss/sub_2_grad/tuple/control_dependencyIdentity!gradients/loss/sub_2_grad/Reshape+^gradients/loss/sub_2_grad/tuple/group_deps*
T0*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/sub_2_grad/Reshape
�
4gradients/loss/sub_2_grad/tuple/control_dependency_1Identity#gradients/loss/sub_2_grad/Reshape_1+^gradients/loss/sub_2_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/sub_2_grad/Reshape_1
b
gradients/loss/add_5_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/add_5_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/add_5_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_5_grad/Shape!gradients/loss/add_5_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/add_5_grad/SumSum2gradients/loss/sub_2_grad/tuple/control_dependency/gradients/loss/add_5_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/add_5_grad/ReshapeReshapegradients/loss/add_5_grad/Sumgradients/loss/add_5_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
�
gradients/loss/add_5_grad/Sum_1Sum2gradients/loss/sub_2_grad/tuple/control_dependency1gradients/loss/add_5_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/add_5_grad/Reshape_1Reshapegradients/loss/add_5_grad/Sum_1!gradients/loss/add_5_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_5_grad/tuple/group_depsNoOp"^gradients/loss/add_5_grad/Reshape$^gradients/loss/add_5_grad/Reshape_1
�
2gradients/loss/add_5_grad/tuple/control_dependencyIdentity!gradients/loss/add_5_grad/Reshape+^gradients/loss/add_5_grad/tuple/group_deps*
T0*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/add_5_grad/Reshape
�
4gradients/loss/add_5_grad/tuple/control_dependency_1Identity#gradients/loss/add_5_grad/Reshape_1+^gradients/loss/add_5_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/add_5_grad/Reshape_1
q
'gradients/loss/Sum_1_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
�
!gradients/loss/Sum_1_grad/ReshapeReshape4gradients/loss/sub_2_grad/tuple/control_dependency_1'gradients/loss/Sum_1_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
s
(gradients/loss/Sum_1_grad/Tile/multiplesConst*
_output_shapes
:*
dtype0*
valueB:�
�
gradients/loss/Sum_1_grad/TileTile!gradients/loss/Sum_1_grad/Reshape(gradients/loss/Sum_1_grad/Tile/multiples*
T0*
_output_shapes	
:�*

Tmultiples0
b
gradients/loss/add_4_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/add_4_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/add_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_4_grad/Shape!gradients/loss/add_4_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/add_4_grad/SumSum2gradients/loss/add_5_grad/tuple/control_dependency/gradients/loss/add_4_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/add_4_grad/ReshapeReshapegradients/loss/add_4_grad/Sumgradients/loss/add_4_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
�
gradients/loss/add_4_grad/Sum_1Sum2gradients/loss/add_5_grad/tuple/control_dependency1gradients/loss/add_4_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/add_4_grad/Reshape_1Reshapegradients/loss/add_4_grad/Sum_1!gradients/loss/add_4_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_4_grad/tuple/group_depsNoOp"^gradients/loss/add_4_grad/Reshape$^gradients/loss/add_4_grad/Reshape_1
�
2gradients/loss/add_4_grad/tuple/control_dependencyIdentity!gradients/loss/add_4_grad/Reshape+^gradients/loss/add_4_grad/tuple/group_deps*
T0*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/add_4_grad/Reshape
�
4gradients/loss/add_4_grad/tuple/control_dependency_1Identity#gradients/loss/add_4_grad/Reshape_1+^gradients/loss/add_4_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/add_4_grad/Reshape_1
b
gradients/loss/add_3_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/add_3_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/add_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_3_grad/Shape!gradients/loss/add_3_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/add_3_grad/SumSum4gradients/loss/add_5_grad/tuple/control_dependency_1/gradients/loss/add_3_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/add_3_grad/ReshapeReshapegradients/loss/add_3_grad/Sumgradients/loss/add_3_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
�
gradients/loss/add_3_grad/Sum_1Sum4gradients/loss/add_5_grad/tuple/control_dependency_11gradients/loss/add_3_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/add_3_grad/Reshape_1Reshapegradients/loss/add_3_grad/Sum_1!gradients/loss/add_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_3_grad/tuple/group_depsNoOp"^gradients/loss/add_3_grad/Reshape$^gradients/loss/add_3_grad/Reshape_1
�
2gradients/loss/add_3_grad/tuple/control_dependencyIdentity!gradients/loss/add_3_grad/Reshape+^gradients/loss/add_3_grad/tuple/group_deps*
T0*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/add_3_grad/Reshape
�
4gradients/loss/add_3_grad/tuple/control_dependency_1Identity#gradients/loss/add_3_grad/Reshape_1+^gradients/loss/add_3_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/add_3_grad/Reshape_1
j
gradients/loss/Neg_1_grad/NegNeggradients/loss/Sum_1_grad/Tile*
T0*
_output_shapes	
:�
b
gradients/loss/mul_1_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/mul_1_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_1_grad/Shape!gradients/loss/mul_1_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/mul_1_grad/mulMul2gradients/loss/add_4_grad/tuple/control_dependency
loss/Sum_2*
T0*
_output_shapes
: 
�
gradients/loss/mul_1_grad/SumSumgradients/loss/mul_1_grad/mul/gradients/loss/mul_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/mul_1_grad/ReshapeReshapegradients/loss/mul_1_grad/Sumgradients/loss/mul_1_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
�
gradients/loss/mul_1_grad/mul_1Mulloss/mul_1/x2gradients/loss/add_4_grad/tuple/control_dependency*
T0*
_output_shapes
: 
�
gradients/loss/mul_1_grad/Sum_1Sumgradients/loss/mul_1_grad/mul_11gradients/loss/mul_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/mul_1_grad/Reshape_1Reshapegradients/loss/mul_1_grad/Sum_1!gradients/loss/mul_1_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/mul_1_grad/tuple/group_depsNoOp"^gradients/loss/mul_1_grad/Reshape$^gradients/loss/mul_1_grad/Reshape_1
�
2gradients/loss/mul_1_grad/tuple/control_dependencyIdentity!gradients/loss/mul_1_grad/Reshape+^gradients/loss/mul_1_grad/tuple/group_deps*
T0*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/mul_1_grad/Reshape
�
4gradients/loss/mul_1_grad/tuple/control_dependency_1Identity#gradients/loss/mul_1_grad/Reshape_1+^gradients/loss/mul_1_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/mul_1_grad/Reshape_1
b
gradients/loss/add_2_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/add_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/add_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_2_grad/Shape!gradients/loss/add_2_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/add_2_grad/SumSum4gradients/loss/add_4_grad/tuple/control_dependency_1/gradients/loss/add_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/add_2_grad/ReshapeReshapegradients/loss/add_2_grad/Sumgradients/loss/add_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
�
gradients/loss/add_2_grad/Sum_1Sum4gradients/loss/add_4_grad/tuple/control_dependency_11gradients/loss/add_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/add_2_grad/Reshape_1Reshapegradients/loss/add_2_grad/Sum_1!gradients/loss/add_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_2_grad/tuple/group_depsNoOp"^gradients/loss/add_2_grad/Reshape$^gradients/loss/add_2_grad/Reshape_1
�
2gradients/loss/add_2_grad/tuple/control_dependencyIdentity!gradients/loss/add_2_grad/Reshape+^gradients/loss/add_2_grad/tuple/group_deps*
T0*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/add_2_grad/Reshape
�
4gradients/loss/add_2_grad/tuple/control_dependency_1Identity#gradients/loss/add_2_grad/Reshape_1+^gradients/loss/add_2_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/add_2_grad/Reshape_1
b
gradients/loss/mul_3_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/mul_3_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_3_grad/Shape!gradients/loss/mul_3_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/mul_3_grad/mulMul2gradients/loss/add_3_grad/tuple/control_dependency
loss/Sum_5*
T0*
_output_shapes
: 
�
gradients/loss/mul_3_grad/SumSumgradients/loss/mul_3_grad/mul/gradients/loss/mul_3_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/mul_3_grad/ReshapeReshapegradients/loss/mul_3_grad/Sumgradients/loss/mul_3_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
�
gradients/loss/mul_3_grad/mul_1Mulloss/mul_3/x2gradients/loss/add_3_grad/tuple/control_dependency*
T0*
_output_shapes
: 
�
gradients/loss/mul_3_grad/Sum_1Sumgradients/loss/mul_3_grad/mul_11gradients/loss/mul_3_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/mul_3_grad/Reshape_1Reshapegradients/loss/mul_3_grad/Sum_1!gradients/loss/mul_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/mul_3_grad/tuple/group_depsNoOp"^gradients/loss/mul_3_grad/Reshape$^gradients/loss/mul_3_grad/Reshape_1
�
2gradients/loss/mul_3_grad/tuple/control_dependencyIdentity!gradients/loss/mul_3_grad/Reshape+^gradients/loss/mul_3_grad/tuple/group_deps*
T0*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/mul_3_grad/Reshape
�
4gradients/loss/mul_3_grad/tuple/control_dependency_1Identity#gradients/loss/mul_3_grad/Reshape_1+^gradients/loss/mul_3_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/mul_3_grad/Reshape_1
q
'gradients/loss/Sum_6_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
�
!gradients/loss/Sum_6_grad/ReshapeReshape4gradients/loss/add_3_grad/tuple/control_dependency_1'gradients/loss/Sum_6_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
s
(gradients/loss/Sum_6_grad/Tile/multiplesConst*
_output_shapes
:*
dtype0*
valueB:�
�
gradients/loss/Sum_6_grad/TileTile!gradients/loss/Sum_6_grad/Reshape(gradients/loss/Sum_6_grad/Tile/multiples*
T0*
_output_shapes	
:�*

Tmultiples0
�
"gradients/loss/Log_grad/Reciprocal
Reciprocal
loss/add_1^gradients/loss/Neg_1_grad/Neg*
T0*
_output_shapes	
:�
�
gradients/loss/Log_grad/mulMulgradients/loss/Neg_1_grad/Neg"gradients/loss/Log_grad/Reciprocal*
T0*
_output_shapes	
:�
x
'gradients/loss/Sum_2_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"      
�
!gradients/loss/Sum_2_grad/ReshapeReshape4gradients/loss/mul_1_grad/tuple/control_dependency_1'gradients/loss/Sum_2_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
y
(gradients/loss/Sum_2_grad/Tile/multiplesConst*
_output_shapes
:*
dtype0*
valueB"�   
   
�
gradients/loss/Sum_2_grad/TileTile!gradients/loss/Sum_2_grad/Reshape(gradients/loss/Sum_2_grad/Tile/multiples*
T0*
_output_shapes
:	�
*

Tmultiples0
b
gradients/loss/mul_2_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/mul_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_2_grad/Shape!gradients/loss/mul_2_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/mul_2_grad/mulMul2gradients/loss/add_2_grad/tuple/control_dependency
loss/Sum_3*
T0*
_output_shapes
: 
�
gradients/loss/mul_2_grad/SumSumgradients/loss/mul_2_grad/mul/gradients/loss/mul_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/mul_2_grad/ReshapeReshapegradients/loss/mul_2_grad/Sumgradients/loss/mul_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
�
gradients/loss/mul_2_grad/mul_1Mulloss/mul_2/x2gradients/loss/add_2_grad/tuple/control_dependency*
T0*
_output_shapes
: 
�
gradients/loss/mul_2_grad/Sum_1Sumgradients/loss/mul_2_grad/mul_11gradients/loss/mul_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/mul_2_grad/Reshape_1Reshapegradients/loss/mul_2_grad/Sum_1!gradients/loss/mul_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/mul_2_grad/tuple/group_depsNoOp"^gradients/loss/mul_2_grad/Reshape$^gradients/loss/mul_2_grad/Reshape_1
�
2gradients/loss/mul_2_grad/tuple/control_dependencyIdentity!gradients/loss/mul_2_grad/Reshape+^gradients/loss/mul_2_grad/tuple/group_deps*
T0*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/mul_2_grad/Reshape
�
4gradients/loss/mul_2_grad/tuple/control_dependency_1Identity#gradients/loss/mul_2_grad/Reshape_1+^gradients/loss/mul_2_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/mul_2_grad/Reshape_1
q
'gradients/loss/Sum_4_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
�
!gradients/loss/Sum_4_grad/ReshapeReshape4gradients/loss/add_2_grad/tuple/control_dependency_1'gradients/loss/Sum_4_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
s
(gradients/loss/Sum_4_grad/Tile/multiplesConst*
_output_shapes
:*
dtype0*
valueB:�
�
gradients/loss/Sum_4_grad/TileTile!gradients/loss/Sum_4_grad/Reshape(gradients/loss/Sum_4_grad/Tile/multiples*
T0*
_output_shapes	
:�*

Tmultiples0
x
'gradients/loss/Sum_5_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"      
�
!gradients/loss/Sum_5_grad/ReshapeReshape4gradients/loss/mul_3_grad/tuple/control_dependency_1'gradients/loss/Sum_5_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
y
(gradients/loss/Sum_5_grad/Tile/multiplesConst*
_output_shapes
:*
dtype0*
valueB"�   
   
�
gradients/loss/Sum_5_grad/TileTile!gradients/loss/Sum_5_grad/Reshape(gradients/loss/Sum_5_grad/Tile/multiples*
T0*
_output_shapes
:	�
*

Tmultiples0
j
gradients/loss/pow_4_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB:�
d
!gradients/loss/pow_4_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_4_grad/Shape!gradients/loss/pow_4_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
x
gradients/loss/pow_4_grad/mulMulgradients/loss/Sum_6_grad/Tileloss/pow_4/y*
T0*
_output_shapes	
:�
d
gradients/loss/pow_4_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
t
gradients/loss/pow_4_grad/subSubloss/pow_4/ygradients/loss/pow_4_grad/sub/y*
T0*
_output_shapes
: 
}
gradients/loss/pow_4_grad/PowPowloss/neg_item_biasgradients/loss/pow_4_grad/sub*
T0*
_output_shapes	
:�
�
gradients/loss/pow_4_grad/mul_1Mulgradients/loss/pow_4_grad/mulgradients/loss/pow_4_grad/Pow*
T0*
_output_shapes	
:�
�
gradients/loss/pow_4_grad/SumSumgradients/loss/pow_4_grad/mul_1/gradients/loss/pow_4_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/pow_4_grad/ReshapeReshapegradients/loss/pow_4_grad/Sumgradients/loss/pow_4_grad/Shape*
T0*
Tshape0*
_output_shapes	
:�
h
#gradients/loss/pow_4_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
!gradients/loss/pow_4_grad/GreaterGreaterloss/neg_item_bias#gradients/loss/pow_4_grad/Greater/y*
T0*
_output_shapes	
:�
^
gradients/loss/pow_4_grad/LogLogloss/neg_item_bias*
T0*
_output_shapes	
:�
k
$gradients/loss/pow_4_grad/zeros_like	ZerosLikeloss/neg_item_bias*
T0*
_output_shapes	
:�
�
 gradients/loss/pow_4_grad/SelectSelect!gradients/loss/pow_4_grad/Greatergradients/loss/pow_4_grad/Log$gradients/loss/pow_4_grad/zeros_like*
T0*
_output_shapes	
:�
x
gradients/loss/pow_4_grad/mul_2Mulgradients/loss/Sum_6_grad/Tile
loss/pow_4*
T0*
_output_shapes	
:�
�
gradients/loss/pow_4_grad/mul_3Mulgradients/loss/pow_4_grad/mul_2 gradients/loss/pow_4_grad/Select*
T0*
_output_shapes	
:�
�
gradients/loss/pow_4_grad/Sum_1Sumgradients/loss/pow_4_grad/mul_31gradients/loss/pow_4_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/pow_4_grad/Reshape_1Reshapegradients/loss/pow_4_grad/Sum_1!gradients/loss/pow_4_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_4_grad/tuple/group_depsNoOp"^gradients/loss/pow_4_grad/Reshape$^gradients/loss/pow_4_grad/Reshape_1
�
2gradients/loss/pow_4_grad/tuple/control_dependencyIdentity!gradients/loss/pow_4_grad/Reshape+^gradients/loss/pow_4_grad/tuple/group_deps*
T0*
_output_shapes	
:�*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape
�
4gradients/loss/pow_4_grad/tuple/control_dependency_1Identity#gradients/loss/pow_4_grad/Reshape_1+^gradients/loss/pow_4_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/pow_4_grad/Reshape_1
b
gradients/loss/add_1_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
l
!gradients/loss/add_1_grad/Shape_1Const*
_output_shapes
:*
dtype0*
valueB:�
�
/gradients/loss/add_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_1_grad/Shape!gradients/loss/add_1_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/add_1_grad/SumSumgradients/loss/Log_grad/mul/gradients/loss/add_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/add_1_grad/ReshapeReshapegradients/loss/add_1_grad/Sumgradients/loss/add_1_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
�
gradients/loss/add_1_grad/Sum_1Sumgradients/loss/Log_grad/mul1gradients/loss/add_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/add_1_grad/Reshape_1Reshapegradients/loss/add_1_grad/Sum_1!gradients/loss/add_1_grad/Shape_1*
T0*
Tshape0*
_output_shapes	
:�
|
*gradients/loss/add_1_grad/tuple/group_depsNoOp"^gradients/loss/add_1_grad/Reshape$^gradients/loss/add_1_grad/Reshape_1
�
2gradients/loss/add_1_grad/tuple/control_dependencyIdentity!gradients/loss/add_1_grad/Reshape+^gradients/loss/add_1_grad/tuple/group_deps*
T0*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/add_1_grad/Reshape
�
4gradients/loss/add_1_grad/tuple/control_dependency_1Identity#gradients/loss/add_1_grad/Reshape_1+^gradients/loss/add_1_grad/tuple/group_deps*
T0*
_output_shapes	
:�*6
_class,
*(loc:@gradients/loss/add_1_grad/Reshape_1
n
gradients/loss/pow_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"�   
   
b
gradients/loss/pow_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
-gradients/loss/pow_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_grad/Shapegradients/loss/pow_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
x
gradients/loss/pow_grad/mulMulgradients/loss/Sum_2_grad/Tile
loss/pow/y*
T0*
_output_shapes
:	�

b
gradients/loss/pow_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
n
gradients/loss/pow_grad/subSub
loss/pow/ygradients/loss/pow_grad/sub/y*
T0*
_output_shapes
: 
u
gradients/loss/pow_grad/PowPow
loss/usersgradients/loss/pow_grad/sub*
T0*
_output_shapes
:	�

�
gradients/loss/pow_grad/mul_1Mulgradients/loss/pow_grad/mulgradients/loss/pow_grad/Pow*
T0*
_output_shapes
:	�

�
gradients/loss/pow_grad/SumSumgradients/loss/pow_grad/mul_1-gradients/loss/pow_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
gradients/loss/pow_grad/ReshapeReshapegradients/loss/pow_grad/Sumgradients/loss/pow_grad/Shape*
T0*
Tshape0*
_output_shapes
:	�

f
!gradients/loss/pow_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
gradients/loss/pow_grad/GreaterGreater
loss/users!gradients/loss/pow_grad/Greater/y*
T0*
_output_shapes
:	�

X
gradients/loss/pow_grad/LogLog
loss/users*
T0*
_output_shapes
:	�

e
"gradients/loss/pow_grad/zeros_like	ZerosLike
loss/users*
T0*
_output_shapes
:	�

�
gradients/loss/pow_grad/SelectSelectgradients/loss/pow_grad/Greatergradients/loss/pow_grad/Log"gradients/loss/pow_grad/zeros_like*
T0*
_output_shapes
:	�

x
gradients/loss/pow_grad/mul_2Mulgradients/loss/Sum_2_grad/Tileloss/pow*
T0*
_output_shapes
:	�

�
gradients/loss/pow_grad/mul_3Mulgradients/loss/pow_grad/mul_2gradients/loss/pow_grad/Select*
T0*
_output_shapes
:	�

�
gradients/loss/pow_grad/Sum_1Sumgradients/loss/pow_grad/mul_3/gradients/loss/pow_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/pow_grad/Reshape_1Reshapegradients/loss/pow_grad/Sum_1gradients/loss/pow_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
v
(gradients/loss/pow_grad/tuple/group_depsNoOp ^gradients/loss/pow_grad/Reshape"^gradients/loss/pow_grad/Reshape_1
�
0gradients/loss/pow_grad/tuple/control_dependencyIdentitygradients/loss/pow_grad/Reshape)^gradients/loss/pow_grad/tuple/group_deps*
T0*
_output_shapes
:	�
*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape
�
2gradients/loss/pow_grad/tuple/control_dependency_1Identity!gradients/loss/pow_grad/Reshape_1)^gradients/loss/pow_grad/tuple/group_deps*
T0*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/pow_grad/Reshape_1
x
'gradients/loss/Sum_3_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"      
�
!gradients/loss/Sum_3_grad/ReshapeReshape4gradients/loss/mul_2_grad/tuple/control_dependency_1'gradients/loss/Sum_3_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
y
(gradients/loss/Sum_3_grad/Tile/multiplesConst*
_output_shapes
:*
dtype0*
valueB"�   
   
�
gradients/loss/Sum_3_grad/TileTile!gradients/loss/Sum_3_grad/Reshape(gradients/loss/Sum_3_grad/Tile/multiples*
T0*
_output_shapes
:	�
*

Tmultiples0
j
gradients/loss/pow_2_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB:�
d
!gradients/loss/pow_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_2_grad/Shape!gradients/loss/pow_2_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
x
gradients/loss/pow_2_grad/mulMulgradients/loss/Sum_4_grad/Tileloss/pow_2/y*
T0*
_output_shapes	
:�
d
gradients/loss/pow_2_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
t
gradients/loss/pow_2_grad/subSubloss/pow_2/ygradients/loss/pow_2_grad/sub/y*
T0*
_output_shapes
: 
}
gradients/loss/pow_2_grad/PowPowloss/pos_item_biasgradients/loss/pow_2_grad/sub*
T0*
_output_shapes	
:�
�
gradients/loss/pow_2_grad/mul_1Mulgradients/loss/pow_2_grad/mulgradients/loss/pow_2_grad/Pow*
T0*
_output_shapes	
:�
�
gradients/loss/pow_2_grad/SumSumgradients/loss/pow_2_grad/mul_1/gradients/loss/pow_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/pow_2_grad/ReshapeReshapegradients/loss/pow_2_grad/Sumgradients/loss/pow_2_grad/Shape*
T0*
Tshape0*
_output_shapes	
:�
h
#gradients/loss/pow_2_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
!gradients/loss/pow_2_grad/GreaterGreaterloss/pos_item_bias#gradients/loss/pow_2_grad/Greater/y*
T0*
_output_shapes	
:�
^
gradients/loss/pow_2_grad/LogLogloss/pos_item_bias*
T0*
_output_shapes	
:�
k
$gradients/loss/pow_2_grad/zeros_like	ZerosLikeloss/pos_item_bias*
T0*
_output_shapes	
:�
�
 gradients/loss/pow_2_grad/SelectSelect!gradients/loss/pow_2_grad/Greatergradients/loss/pow_2_grad/Log$gradients/loss/pow_2_grad/zeros_like*
T0*
_output_shapes	
:�
x
gradients/loss/pow_2_grad/mul_2Mulgradients/loss/Sum_4_grad/Tile
loss/pow_2*
T0*
_output_shapes	
:�
�
gradients/loss/pow_2_grad/mul_3Mulgradients/loss/pow_2_grad/mul_2 gradients/loss/pow_2_grad/Select*
T0*
_output_shapes	
:�
�
gradients/loss/pow_2_grad/Sum_1Sumgradients/loss/pow_2_grad/mul_31gradients/loss/pow_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/pow_2_grad/Reshape_1Reshapegradients/loss/pow_2_grad/Sum_1!gradients/loss/pow_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_2_grad/tuple/group_depsNoOp"^gradients/loss/pow_2_grad/Reshape$^gradients/loss/pow_2_grad/Reshape_1
�
2gradients/loss/pow_2_grad/tuple/control_dependencyIdentity!gradients/loss/pow_2_grad/Reshape+^gradients/loss/pow_2_grad/tuple/group_deps*
T0*
_output_shapes	
:�*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape
�
4gradients/loss/pow_2_grad/tuple/control_dependency_1Identity#gradients/loss/pow_2_grad/Reshape_1+^gradients/loss/pow_2_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/pow_2_grad/Reshape_1
p
gradients/loss/pow_3_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"�   
   
d
!gradients/loss/pow_3_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_3_grad/Shape!gradients/loss/pow_3_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
|
gradients/loss/pow_3_grad/mulMulgradients/loss/Sum_5_grad/Tileloss/pow_3/y*
T0*
_output_shapes
:	�

d
gradients/loss/pow_3_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
t
gradients/loss/pow_3_grad/subSubloss/pow_3/ygradients/loss/pow_3_grad/sub/y*
T0*
_output_shapes
: 
}
gradients/loss/pow_3_grad/PowPowloss/neg_itemsgradients/loss/pow_3_grad/sub*
T0*
_output_shapes
:	�

�
gradients/loss/pow_3_grad/mul_1Mulgradients/loss/pow_3_grad/mulgradients/loss/pow_3_grad/Pow*
T0*
_output_shapes
:	�

�
gradients/loss/pow_3_grad/SumSumgradients/loss/pow_3_grad/mul_1/gradients/loss/pow_3_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/pow_3_grad/ReshapeReshapegradients/loss/pow_3_grad/Sumgradients/loss/pow_3_grad/Shape*
T0*
Tshape0*
_output_shapes
:	�

h
#gradients/loss/pow_3_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
!gradients/loss/pow_3_grad/GreaterGreaterloss/neg_items#gradients/loss/pow_3_grad/Greater/y*
T0*
_output_shapes
:	�

^
gradients/loss/pow_3_grad/LogLogloss/neg_items*
T0*
_output_shapes
:	�

k
$gradients/loss/pow_3_grad/zeros_like	ZerosLikeloss/neg_items*
T0*
_output_shapes
:	�

�
 gradients/loss/pow_3_grad/SelectSelect!gradients/loss/pow_3_grad/Greatergradients/loss/pow_3_grad/Log$gradients/loss/pow_3_grad/zeros_like*
T0*
_output_shapes
:	�

|
gradients/loss/pow_3_grad/mul_2Mulgradients/loss/Sum_5_grad/Tile
loss/pow_3*
T0*
_output_shapes
:	�

�
gradients/loss/pow_3_grad/mul_3Mulgradients/loss/pow_3_grad/mul_2 gradients/loss/pow_3_grad/Select*
T0*
_output_shapes
:	�

�
gradients/loss/pow_3_grad/Sum_1Sumgradients/loss/pow_3_grad/mul_31gradients/loss/pow_3_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/pow_3_grad/Reshape_1Reshapegradients/loss/pow_3_grad/Sum_1!gradients/loss/pow_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_3_grad/tuple/group_depsNoOp"^gradients/loss/pow_3_grad/Reshape$^gradients/loss/pow_3_grad/Reshape_1
�
2gradients/loss/pow_3_grad/tuple/control_dependencyIdentity!gradients/loss/pow_3_grad/Reshape+^gradients/loss/pow_3_grad/tuple/group_deps*
T0*
_output_shapes
:	�
*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape
�
4gradients/loss/pow_3_grad/tuple/control_dependency_1Identity#gradients/loss/pow_3_grad/Reshape_1+^gradients/loss/pow_3_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/pow_3_grad/Reshape_1
�
gradients/loss/Exp_grad/mulMul4gradients/loss/add_1_grad/tuple/control_dependency_1loss/Exp*
T0*
_output_shapes	
:�
p
gradients/loss/pow_1_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"�   
   
d
!gradients/loss/pow_1_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_1_grad/Shape!gradients/loss/pow_1_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
|
gradients/loss/pow_1_grad/mulMulgradients/loss/Sum_3_grad/Tileloss/pow_1/y*
T0*
_output_shapes
:	�

d
gradients/loss/pow_1_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
t
gradients/loss/pow_1_grad/subSubloss/pow_1/ygradients/loss/pow_1_grad/sub/y*
T0*
_output_shapes
: 
}
gradients/loss/pow_1_grad/PowPowloss/pos_itemsgradients/loss/pow_1_grad/sub*
T0*
_output_shapes
:	�

�
gradients/loss/pow_1_grad/mul_1Mulgradients/loss/pow_1_grad/mulgradients/loss/pow_1_grad/Pow*
T0*
_output_shapes
:	�

�
gradients/loss/pow_1_grad/SumSumgradients/loss/pow_1_grad/mul_1/gradients/loss/pow_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/pow_1_grad/ReshapeReshapegradients/loss/pow_1_grad/Sumgradients/loss/pow_1_grad/Shape*
T0*
Tshape0*
_output_shapes
:	�

h
#gradients/loss/pow_1_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
!gradients/loss/pow_1_grad/GreaterGreaterloss/pos_items#gradients/loss/pow_1_grad/Greater/y*
T0*
_output_shapes
:	�

^
gradients/loss/pow_1_grad/LogLogloss/pos_items*
T0*
_output_shapes
:	�

k
$gradients/loss/pow_1_grad/zeros_like	ZerosLikeloss/pos_items*
T0*
_output_shapes
:	�

�
 gradients/loss/pow_1_grad/SelectSelect!gradients/loss/pow_1_grad/Greatergradients/loss/pow_1_grad/Log$gradients/loss/pow_1_grad/zeros_like*
T0*
_output_shapes
:	�

|
gradients/loss/pow_1_grad/mul_2Mulgradients/loss/Sum_3_grad/Tile
loss/pow_1*
T0*
_output_shapes
:	�

�
gradients/loss/pow_1_grad/mul_3Mulgradients/loss/pow_1_grad/mul_2 gradients/loss/pow_1_grad/Select*
T0*
_output_shapes
:	�

�
gradients/loss/pow_1_grad/Sum_1Sumgradients/loss/pow_1_grad/mul_31gradients/loss/pow_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/pow_1_grad/Reshape_1Reshapegradients/loss/pow_1_grad/Sum_1!gradients/loss/pow_1_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_1_grad/tuple/group_depsNoOp"^gradients/loss/pow_1_grad/Reshape$^gradients/loss/pow_1_grad/Reshape_1
�
2gradients/loss/pow_1_grad/tuple/control_dependencyIdentity!gradients/loss/pow_1_grad/Reshape+^gradients/loss/pow_1_grad/tuple/group_deps*
T0*
_output_shapes
:	�
*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape
�
4gradients/loss/pow_1_grad/tuple/control_dependency_1Identity#gradients/loss/pow_1_grad/Reshape_1+^gradients/loss/pow_1_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/pow_1_grad/Reshape_1
e
gradients/loss/Neg_grad/NegNeggradients/loss/Exp_grad/mul*
T0*
_output_shapes	
:�
h
gradients/loss/add_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB:�
j
gradients/loss/add_grad/Shape_1Const*
_output_shapes
:*
dtype0*
valueB:�
�
-gradients/loss/add_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_grad/Shapegradients/loss/add_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/add_grad/SumSumgradients/loss/Neg_grad/Neg-gradients/loss/add_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
gradients/loss/add_grad/ReshapeReshapegradients/loss/add_grad/Sumgradients/loss/add_grad/Shape*
T0*
Tshape0*
_output_shapes	
:�
�
gradients/loss/add_grad/Sum_1Sumgradients/loss/Neg_grad/Neg/gradients/loss/add_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/add_grad/Reshape_1Reshapegradients/loss/add_grad/Sum_1gradients/loss/add_grad/Shape_1*
T0*
Tshape0*
_output_shapes	
:�
v
(gradients/loss/add_grad/tuple/group_depsNoOp ^gradients/loss/add_grad/Reshape"^gradients/loss/add_grad/Reshape_1
�
0gradients/loss/add_grad/tuple/control_dependencyIdentitygradients/loss/add_grad/Reshape)^gradients/loss/add_grad/tuple/group_deps*
T0*
_output_shapes	
:�*2
_class(
&$loc:@gradients/loss/add_grad/Reshape
�
2gradients/loss/add_grad/tuple/control_dependency_1Identity!gradients/loss/add_grad/Reshape_1)^gradients/loss/add_grad/tuple/group_deps*
T0*
_output_shapes	
:�*4
_class*
(&loc:@gradients/loss/add_grad/Reshape_1
j
gradients/loss/sub_1_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB:�
l
!gradients/loss/sub_1_grad/Shape_1Const*
_output_shapes
:*
dtype0*
valueB:�
�
/gradients/loss/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_1_grad/Shape!gradients/loss/sub_1_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/sub_1_grad/SumSum0gradients/loss/add_grad/tuple/control_dependency/gradients/loss/sub_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/sub_1_grad/ReshapeReshapegradients/loss/sub_1_grad/Sumgradients/loss/sub_1_grad/Shape*
T0*
Tshape0*
_output_shapes	
:�
�
gradients/loss/sub_1_grad/Sum_1Sum0gradients/loss/add_grad/tuple/control_dependency1gradients/loss/sub_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
h
gradients/loss/sub_1_grad/NegNeggradients/loss/sub_1_grad/Sum_1*
T0*
_output_shapes
:
�
#gradients/loss/sub_1_grad/Reshape_1Reshapegradients/loss/sub_1_grad/Neg!gradients/loss/sub_1_grad/Shape_1*
T0*
Tshape0*
_output_shapes	
:�
|
*gradients/loss/sub_1_grad/tuple/group_depsNoOp"^gradients/loss/sub_1_grad/Reshape$^gradients/loss/sub_1_grad/Reshape_1
�
2gradients/loss/sub_1_grad/tuple/control_dependencyIdentity!gradients/loss/sub_1_grad/Reshape+^gradients/loss/sub_1_grad/tuple/group_deps*
T0*
_output_shapes	
:�*4
_class*
(&loc:@gradients/loss/sub_1_grad/Reshape
�
4gradients/loss/sub_1_grad/tuple/control_dependency_1Identity#gradients/loss/sub_1_grad/Reshape_1+^gradients/loss/sub_1_grad/tuple/group_deps*
T0*
_output_shapes	
:�*6
_class,
*(loc:@gradients/loss/sub_1_grad/Reshape_1
n
gradients/loss/Sum_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"�   
   
^
gradients/loss/Sum_grad/SizeConst*
_output_shapes
: *
dtype0*
value	B :
}
gradients/loss/Sum_grad/addAddloss/Sum/reduction_indicesgradients/loss/Sum_grad/Size*
T0*
_output_shapes
: 
�
gradients/loss/Sum_grad/modFloorModgradients/loss/Sum_grad/addgradients/loss/Sum_grad/Size*
T0*
_output_shapes
: 
b
gradients/loss/Sum_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
e
#gradients/loss/Sum_grad/range/startConst*
_output_shapes
: *
dtype0*
value	B : 
e
#gradients/loss/Sum_grad/range/deltaConst*
_output_shapes
: *
dtype0*
value	B :
�
gradients/loss/Sum_grad/rangeRange#gradients/loss/Sum_grad/range/startgradients/loss/Sum_grad/Size#gradients/loss/Sum_grad/range/delta*

Tidx0*
_output_shapes
:
d
"gradients/loss/Sum_grad/Fill/valueConst*
_output_shapes
: *
dtype0*
value	B :
�
gradients/loss/Sum_grad/FillFillgradients/loss/Sum_grad/Shape_1"gradients/loss/Sum_grad/Fill/value*
T0*
_output_shapes
: 
�
%gradients/loss/Sum_grad/DynamicStitchDynamicStitchgradients/loss/Sum_grad/rangegradients/loss/Sum_grad/modgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Fill*
T0*#
_output_shapes
:���������*
N
c
!gradients/loss/Sum_grad/Maximum/yConst*
_output_shapes
: *
dtype0*
value	B :
�
gradients/loss/Sum_grad/MaximumMaximum%gradients/loss/Sum_grad/DynamicStitch!gradients/loss/Sum_grad/Maximum/y*
T0*#
_output_shapes
:���������
�
 gradients/loss/Sum_grad/floordivFloorDivgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Maximum*
T0*
_output_shapes
:
�
gradients/loss/Sum_grad/ReshapeReshape2gradients/loss/add_grad/tuple/control_dependency_1%gradients/loss/Sum_grad/DynamicStitch*
T0*
Tshape0*
_output_shapes
:
�
gradients/loss/Sum_grad/TileTilegradients/loss/Sum_grad/Reshape gradients/loss/Sum_grad/floordiv*
T0*
_output_shapes
:	�
*

Tmultiples0
�
gradients/AddNAddN2gradients/loss/pow_2_grad/tuple/control_dependency2gradients/loss/sub_1_grad/tuple/control_dependency*
T0*
_output_shapes	
:�*
N*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape
�
'gradients/loss/pos_item_bias_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB:�*&
_class
loc:@variables/item_bias
i
&gradients/loss/pos_item_bias_grad/SizeConst*
_output_shapes
: *
dtype0*
value
B :�
r
0gradients/loss/pos_item_bias_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
,gradients/loss/pos_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/pos_item_bias_grad/Size0gradients/loss/pos_item_bias_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:

5gradients/loss/pos_item_bias_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
�
7gradients/loss/pos_item_bias_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
�
7gradients/loss/pos_item_bias_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
/gradients/loss/pos_item_bias_grad/strided_sliceStridedSlice'gradients/loss/pos_item_bias_grad/Shape5gradients/loss/pos_item_bias_grad/strided_slice/stack7gradients/loss/pos_item_bias_grad/strided_slice/stack_17gradients/loss/pos_item_bias_grad/strided_slice/stack_2*
Index0*
shrink_axis_mask *
end_mask*
new_axis_mask *
ellipsis_mask *

begin_mask *
T0*
_output_shapes
: 
o
-gradients/loss/pos_item_bias_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
(gradients/loss/pos_item_bias_grad/concatConcatV2,gradients/loss/pos_item_bias_grad/ExpandDims/gradients/loss/pos_item_bias_grad/strided_slice-gradients/loss/pos_item_bias_grad/concat/axis*
T0*

Tidx0*
N*
_output_shapes
:
�
)gradients/loss/pos_item_bias_grad/ReshapeReshapegradients/AddN(gradients/loss/pos_item_bias_grad/concat*
T0*
Tshape0*
_output_shapes	
:�
�
+gradients/loss/pos_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_pos_items,gradients/loss/pos_item_bias_grad/ExpandDims*
T0*
Tshape0*
_output_shapes	
:�
�
gradients/AddN_1AddN2gradients/loss/pow_4_grad/tuple/control_dependency4gradients/loss/sub_1_grad/tuple/control_dependency_1*
T0*
_output_shapes	
:�*
N*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape
�
'gradients/loss/neg_item_bias_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB:�*&
_class
loc:@variables/item_bias
i
&gradients/loss/neg_item_bias_grad/SizeConst*
_output_shapes
: *
dtype0*
value
B :�
r
0gradients/loss/neg_item_bias_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
,gradients/loss/neg_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/neg_item_bias_grad/Size0gradients/loss/neg_item_bias_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:

5gradients/loss/neg_item_bias_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
�
7gradients/loss/neg_item_bias_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
�
7gradients/loss/neg_item_bias_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
/gradients/loss/neg_item_bias_grad/strided_sliceStridedSlice'gradients/loss/neg_item_bias_grad/Shape5gradients/loss/neg_item_bias_grad/strided_slice/stack7gradients/loss/neg_item_bias_grad/strided_slice/stack_17gradients/loss/neg_item_bias_grad/strided_slice/stack_2*
Index0*
shrink_axis_mask *
end_mask*
new_axis_mask *
ellipsis_mask *

begin_mask *
T0*
_output_shapes
: 
o
-gradients/loss/neg_item_bias_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
(gradients/loss/neg_item_bias_grad/concatConcatV2,gradients/loss/neg_item_bias_grad/ExpandDims/gradients/loss/neg_item_bias_grad/strided_slice-gradients/loss/neg_item_bias_grad/concat/axis*
T0*

Tidx0*
N*
_output_shapes
:
�
)gradients/loss/neg_item_bias_grad/ReshapeReshapegradients/AddN_1(gradients/loss/neg_item_bias_grad/concat*
T0*
Tshape0*
_output_shapes	
:�
�
+gradients/loss/neg_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_neg_items,gradients/loss/neg_item_bias_grad/ExpandDims*
T0*
Tshape0*
_output_shapes	
:�
n
gradients/loss/mul_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"�   
   
p
gradients/loss/mul_grad/Shape_1Const*
_output_shapes
:*
dtype0*
valueB"�   
   
�
-gradients/loss/mul_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_grad/Shapegradients/loss/mul_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
t
gradients/loss/mul_grad/mulMulgradients/loss/Sum_grad/Tileloss/sub*
T0*
_output_shapes
:	�

�
gradients/loss/mul_grad/SumSumgradients/loss/mul_grad/mul-gradients/loss/mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
gradients/loss/mul_grad/ReshapeReshapegradients/loss/mul_grad/Sumgradients/loss/mul_grad/Shape*
T0*
Tshape0*
_output_shapes
:	�

x
gradients/loss/mul_grad/mul_1Mul
loss/usersgradients/loss/Sum_grad/Tile*
T0*
_output_shapes
:	�

�
gradients/loss/mul_grad/Sum_1Sumgradients/loss/mul_grad/mul_1/gradients/loss/mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/mul_grad/Reshape_1Reshapegradients/loss/mul_grad/Sum_1gradients/loss/mul_grad/Shape_1*
T0*
Tshape0*
_output_shapes
:	�

v
(gradients/loss/mul_grad/tuple/group_depsNoOp ^gradients/loss/mul_grad/Reshape"^gradients/loss/mul_grad/Reshape_1
�
0gradients/loss/mul_grad/tuple/control_dependencyIdentitygradients/loss/mul_grad/Reshape)^gradients/loss/mul_grad/tuple/group_deps*
T0*
_output_shapes
:	�
*2
_class(
&$loc:@gradients/loss/mul_grad/Reshape
�
2gradients/loss/mul_grad/tuple/control_dependency_1Identity!gradients/loss/mul_grad/Reshape_1)^gradients/loss/mul_grad/tuple/group_deps*
T0*
_output_shapes
:	�
*4
_class*
(&loc:@gradients/loss/mul_grad/Reshape_1
W
gradients/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients/concatConcatV2)gradients/loss/pos_item_bias_grad/Reshape)gradients/loss/neg_item_bias_grad/Reshapegradients/concat/axis*
T0*

Tidx0*
N*
_output_shapes	
:�
Y
gradients/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients/concat_1ConcatV2+gradients/loss/pos_item_bias_grad/Reshape_1+gradients/loss/neg_item_bias_grad/Reshape_1gradients/concat_1/axis*
T0*

Tidx0*
N*
_output_shapes	
:�
�
gradients/AddN_2AddN0gradients/loss/pow_grad/tuple/control_dependency0gradients/loss/mul_grad/tuple/control_dependency*
T0*
_output_shapes
:	�
*
N*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape
�
gradients/loss/users_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"  
   *)
_class
loc:@variables/user_factors
a
gradients/loss/users_grad/SizeConst*
_output_shapes
: *
dtype0*
value
B :�
j
(gradients/loss/users_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
$gradients/loss/users_grad/ExpandDims
ExpandDimsgradients/loss/users_grad/Size(gradients/loss/users_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:
w
-gradients/loss/users_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
y
/gradients/loss/users_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
y
/gradients/loss/users_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
'gradients/loss/users_grad/strided_sliceStridedSlicegradients/loss/users_grad/Shape-gradients/loss/users_grad/strided_slice/stack/gradients/loss/users_grad/strided_slice/stack_1/gradients/loss/users_grad/strided_slice/stack_2*
Index0*
shrink_axis_mask *
end_mask*
new_axis_mask *
ellipsis_mask *

begin_mask *
T0*
_output_shapes
:
g
%gradients/loss/users_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
 gradients/loss/users_grad/concatConcatV2$gradients/loss/users_grad/ExpandDims'gradients/loss/users_grad/strided_slice%gradients/loss/users_grad/concat/axis*
T0*

Tidx0*
N*
_output_shapes
:
�
!gradients/loss/users_grad/ReshapeReshapegradients/AddN_2 gradients/loss/users_grad/concat*
T0*
Tshape0*0
_output_shapes
:������������������
�
#gradients/loss/users_grad/Reshape_1Reshapeplaceholders/sampled_users$gradients/loss/users_grad/ExpandDims*
T0*
Tshape0*
_output_shapes	
:�
n
gradients/loss/sub_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"�   
   
p
gradients/loss/sub_grad/Shape_1Const*
_output_shapes
:*
dtype0*
valueB"�   
   
�
-gradients/loss/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_grad/Shapegradients/loss/sub_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/sub_grad/SumSum2gradients/loss/mul_grad/tuple/control_dependency_1-gradients/loss/sub_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
gradients/loss/sub_grad/ReshapeReshapegradients/loss/sub_grad/Sumgradients/loss/sub_grad/Shape*
T0*
Tshape0*
_output_shapes
:	�

�
gradients/loss/sub_grad/Sum_1Sum2gradients/loss/mul_grad/tuple/control_dependency_1/gradients/loss/sub_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
d
gradients/loss/sub_grad/NegNeggradients/loss/sub_grad/Sum_1*
T0*
_output_shapes
:
�
!gradients/loss/sub_grad/Reshape_1Reshapegradients/loss/sub_grad/Neggradients/loss/sub_grad/Shape_1*
T0*
Tshape0*
_output_shapes
:	�

v
(gradients/loss/sub_grad/tuple/group_depsNoOp ^gradients/loss/sub_grad/Reshape"^gradients/loss/sub_grad/Reshape_1
�
0gradients/loss/sub_grad/tuple/control_dependencyIdentitygradients/loss/sub_grad/Reshape)^gradients/loss/sub_grad/tuple/group_deps*
T0*
_output_shapes
:	�
*2
_class(
&$loc:@gradients/loss/sub_grad/Reshape
�
2gradients/loss/sub_grad/tuple/control_dependency_1Identity!gradients/loss/sub_grad/Reshape_1)^gradients/loss/sub_grad/tuple/group_deps*
T0*
_output_shapes
:	�
*4
_class*
(&loc:@gradients/loss/sub_grad/Reshape_1
�
gradients/AddN_3AddN2gradients/loss/pow_1_grad/tuple/control_dependency0gradients/loss/sub_grad/tuple/control_dependency*
T0*
_output_shapes
:	�
*
N*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape
�
#gradients/loss/pos_items_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"m  
   *)
_class
loc:@variables/item_factors
e
"gradients/loss/pos_items_grad/SizeConst*
_output_shapes
: *
dtype0*
value
B :�
n
,gradients/loss/pos_items_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
(gradients/loss/pos_items_grad/ExpandDims
ExpandDims"gradients/loss/pos_items_grad/Size,gradients/loss/pos_items_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:
{
1gradients/loss/pos_items_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
}
3gradients/loss/pos_items_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
}
3gradients/loss/pos_items_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
+gradients/loss/pos_items_grad/strided_sliceStridedSlice#gradients/loss/pos_items_grad/Shape1gradients/loss/pos_items_grad/strided_slice/stack3gradients/loss/pos_items_grad/strided_slice/stack_13gradients/loss/pos_items_grad/strided_slice/stack_2*
Index0*
shrink_axis_mask *
end_mask*
new_axis_mask *
ellipsis_mask *

begin_mask *
T0*
_output_shapes
:
k
)gradients/loss/pos_items_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
$gradients/loss/pos_items_grad/concatConcatV2(gradients/loss/pos_items_grad/ExpandDims+gradients/loss/pos_items_grad/strided_slice)gradients/loss/pos_items_grad/concat/axis*
T0*

Tidx0*
N*
_output_shapes
:
�
%gradients/loss/pos_items_grad/ReshapeReshapegradients/AddN_3$gradients/loss/pos_items_grad/concat*
T0*
Tshape0*0
_output_shapes
:������������������
�
'gradients/loss/pos_items_grad/Reshape_1Reshapeplaceholders/sampled_pos_items(gradients/loss/pos_items_grad/ExpandDims*
T0*
Tshape0*
_output_shapes	
:�
�
gradients/AddN_4AddN2gradients/loss/pow_3_grad/tuple/control_dependency2gradients/loss/sub_grad/tuple/control_dependency_1*
T0*
_output_shapes
:	�
*
N*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape
�
#gradients/loss/neg_items_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"m  
   *)
_class
loc:@variables/item_factors
e
"gradients/loss/neg_items_grad/SizeConst*
_output_shapes
: *
dtype0*
value
B :�
n
,gradients/loss/neg_items_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
(gradients/loss/neg_items_grad/ExpandDims
ExpandDims"gradients/loss/neg_items_grad/Size,gradients/loss/neg_items_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:
{
1gradients/loss/neg_items_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
}
3gradients/loss/neg_items_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
}
3gradients/loss/neg_items_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
+gradients/loss/neg_items_grad/strided_sliceStridedSlice#gradients/loss/neg_items_grad/Shape1gradients/loss/neg_items_grad/strided_slice/stack3gradients/loss/neg_items_grad/strided_slice/stack_13gradients/loss/neg_items_grad/strided_slice/stack_2*
Index0*
shrink_axis_mask *
end_mask*
new_axis_mask *
ellipsis_mask *

begin_mask *
T0*
_output_shapes
:
k
)gradients/loss/neg_items_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
$gradients/loss/neg_items_grad/concatConcatV2(gradients/loss/neg_items_grad/ExpandDims+gradients/loss/neg_items_grad/strided_slice)gradients/loss/neg_items_grad/concat/axis*
T0*

Tidx0*
N*
_output_shapes
:
�
%gradients/loss/neg_items_grad/ReshapeReshapegradients/AddN_4$gradients/loss/neg_items_grad/concat*
T0*
Tshape0*0
_output_shapes
:������������������
�
'gradients/loss/neg_items_grad/Reshape_1Reshapeplaceholders/sampled_neg_items(gradients/loss/neg_items_grad/ExpandDims*
T0*
Tshape0*
_output_shapes	
:�
Y
gradients/concat_2/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients/concat_2ConcatV2%gradients/loss/pos_items_grad/Reshape%gradients/loss/neg_items_grad/Reshapegradients/concat_2/axis*
T0*

Tidx0*
N*0
_output_shapes
:������������������
Y
gradients/concat_3/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients/concat_3ConcatV2'gradients/loss/pos_items_grad/Reshape_1'gradients/loss/neg_items_grad/Reshape_1gradients/concat_3/axis*
T0*

Tidx0*
N*
_output_shapes	
:�
b
GradientDescent/learning_rateConst*
_output_shapes
: *
dtype0*
valueB
 *���=
�
1GradientDescent/update_variables/user_factors/mulMul!gradients/loss/users_grad/ReshapeGradientDescent/learning_rate*
T0*0
_output_shapes
:������������������*)
_class
loc:@variables/user_factors
�
8GradientDescent/update_variables/user_factors/ScatterSub
ScatterSubvariables/user_factors#gradients/loss/users_grad/Reshape_11GradientDescent/update_variables/user_factors/mul*
T0*
_output_shapes
:	�
*)
_class
loc:@variables/user_factors*
Tindices0*
use_locking( 
�
1GradientDescent/update_variables/item_factors/mulMulgradients/concat_2GradientDescent/learning_rate*
T0*0
_output_shapes
:������������������*)
_class
loc:@variables/item_factors
�
8GradientDescent/update_variables/item_factors/ScatterSub
ScatterSubvariables/item_factorsgradients/concat_31GradientDescent/update_variables/item_factors/mul*
T0*
_output_shapes
:	�
*)
_class
loc:@variables/item_factors*
Tindices0*
use_locking( 
�
.GradientDescent/update_variables/item_bias/mulMulgradients/concatGradientDescent/learning_rate*
T0*
_output_shapes	
:�*&
_class
loc:@variables/item_bias
�
5GradientDescent/update_variables/item_bias/ScatterSub
ScatterSubvariables/item_biasgradients/concat_1.GradientDescent/update_variables/item_bias/mul*
T0*
_output_shapes	
:�*&
_class
loc:@variables/item_bias*
Tindices0*
use_locking( 
�
GradientDescentNoOp9^GradientDescent/update_variables/user_factors/ScatterSub9^GradientDescent/update_variables/item_factors/ScatterSub6^GradientDescent/update_variables/item_bias/ScatterSub
R
loss_1/tagsConst*
_output_shapes
: *
dtype0*
valueB Bloss_1
Q
loss_1ScalarSummaryloss_1/tags
loss/sub_2*
T0*
_output_shapes
: 
K
Merge/MergeSummaryMergeSummaryloss_1*
_output_shapes
: *
N
i
initNoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign"��le     *b�	�Q�^�AJؼ
��
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
2	��
x
Assign
ref"T�

value"T

output_ref"T�"	
Ttype"
validate_shapebool("
use_lockingbool(�
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
�
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
2	�
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
2	�
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
�

ScatterSub
ref"T�
indices"Tindices
updates"T

output_ref"T�"
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
�
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
�
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
2	�
s

VariableV2
ref"dtype�"
shapeshape"
dtypetype"
	containerstring "
shared_namestring �
&
	ZerosLike
x"T
y"T"	
Ttype*1.1.02v1.1.0-rc0-61-g1ec6ed5��
e
placeholders/sampled_usersPlaceholder*
dtype0*
_output_shapes	
:�*
shape:�
i
placeholders/sampled_pos_itemsPlaceholder*
dtype0*
_output_shapes	
:�*
shape:�
i
placeholders/sampled_neg_itemsPlaceholder*
dtype0*
_output_shapes	
:�*
shape:�
q
 variables/truncated_normal/shapeConst*
_output_shapes
:*
dtype0*
valueB"  
   
d
variables/truncated_normal/meanConst*
_output_shapes
: *
dtype0*
valueB
 *    
f
!variables/truncated_normal/stddevConst*
_output_shapes
: *
dtype0*
valueB
 *��>
�
*variables/truncated_normal/TruncatedNormalTruncatedNormal variables/truncated_normal/shape*
T0*
_output_shapes
:	�
*
seed���)*
dtype0*
seed2�	
�
variables/truncated_normal/mulMul*variables/truncated_normal/TruncatedNormal!variables/truncated_normal/stddev*
T0*
_output_shapes
:	�

�
variables/truncated_normalAddvariables/truncated_normal/mulvariables/truncated_normal/mean*
T0*
_output_shapes
:	�

s
"variables/truncated_normal_1/shapeConst*
_output_shapes
:*
dtype0*
valueB"m  
   
f
!variables/truncated_normal_1/meanConst*
_output_shapes
: *
dtype0*
valueB
 *    
h
#variables/truncated_normal_1/stddevConst*
_output_shapes
: *
dtype0*
valueB
 *��>
�
,variables/truncated_normal_1/TruncatedNormalTruncatedNormal"variables/truncated_normal_1/shape*
T0*
_output_shapes
:	�
*
seed���)*
dtype0*
seed2�	
�
 variables/truncated_normal_1/mulMul,variables/truncated_normal_1/TruncatedNormal#variables/truncated_normal_1/stddev*
T0*
_output_shapes
:	�

�
variables/truncated_normal_1Add variables/truncated_normal_1/mul!variables/truncated_normal_1/mean*
T0*
_output_shapes
:	�

�
variables/user_factors
VariableV2*
_output_shapes
:	�
*
	container *
dtype0*
shape:	�
*
shared_name 
�
variables/user_factors/AssignAssignvariables/user_factorsvariables/truncated_normal*
T0*
_output_shapes
:	�
*
validate_shape(*)
_class
loc:@variables/user_factors*
use_locking(
�
variables/user_factors/readIdentityvariables/user_factors*
T0*
_output_shapes
:	�
*)
_class
loc:@variables/user_factors
�
variables/item_factors
VariableV2*
_output_shapes
:	�
*
	container *
dtype0*
shape:	�
*
shared_name 
�
variables/item_factors/AssignAssignvariables/item_factorsvariables/truncated_normal_1*
T0*
_output_shapes
:	�
*
validate_shape(*)
_class
loc:@variables/item_factors*
use_locking(
�
variables/item_factors/readIdentityvariables/item_factors*
T0*
_output_shapes
:	�
*)
_class
loc:@variables/item_factors
^
variables/zerosConst*
_output_shapes	
:�*
dtype0*
valueB�*    
�
variables/item_bias
VariableV2*
_output_shapes	
:�*
	container *
dtype0*
shape:�*
shared_name 
�
variables/item_bias/AssignAssignvariables/item_biasvariables/zeros*
T0*
_output_shapes	
:�*
validate_shape(*&
_class
loc:@variables/item_bias*
use_locking(
�
variables/item_bias/readIdentityvariables/item_bias*
T0*
_output_shapes	
:�*&
_class
loc:@variables/item_bias
�

loss/usersGathervariables/user_factors/readplaceholders/sampled_users*
_output_shapes
:	�
*
Tparams0*
validate_indices(*
Tindices0
�
loss/pos_itemsGathervariables/item_factors/readplaceholders/sampled_pos_items*
_output_shapes
:	�
*
Tparams0*
validate_indices(*
Tindices0
�
loss/neg_itemsGathervariables/item_factors/readplaceholders/sampled_neg_items*
_output_shapes
:	�
*
Tparams0*
validate_indices(*
Tindices0
�
loss/pos_item_biasGathervariables/item_bias/readplaceholders/sampled_pos_items*
_output_shapes	
:�*
Tparams0*
validate_indices(*
Tindices0
�
loss/neg_item_biasGathervariables/item_bias/readplaceholders/sampled_neg_items*
_output_shapes	
:�*
Tparams0*
validate_indices(*
Tindices0
Y
loss/subSubloss/pos_itemsloss/neg_items*
T0*
_output_shapes
:	�

O
loss/mulMul
loss/usersloss/sub*
T0*
_output_shapes
:	�

\
loss/Sum/reduction_indicesConst*
_output_shapes
: *
dtype0*
value	B :
x
loss/SumSumloss/mulloss/Sum/reduction_indices*
T0*

Tidx0*
_output_shapes	
:�*
	keep_dims( 
_

loss/sub_1Subloss/pos_item_biasloss/neg_item_bias*
T0*
_output_shapes	
:�
K
loss/addAdd
loss/sub_1loss/Sum*
T0*
_output_shapes	
:�
?
loss/NegNegloss/add*
T0*
_output_shapes	
:�
?
loss/ExpExploss/Neg*
T0*
_output_shapes	
:�
Q
loss/add_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
O

loss/add_1Addloss/add_1/xloss/Exp*
T0*
_output_shapes	
:�
A
loss/LogLog
loss/add_1*
T0*
_output_shapes	
:�
A

loss/Neg_1Negloss/Log*
T0*
_output_shapes	
:�
T

loss/ConstConst*
_output_shapes
:*
dtype0*
valueB: 
g

loss/Sum_1Sum
loss/Neg_1
loss/Const*
T0*

Tidx0*
_output_shapes
: *
	keep_dims( 
O

loss/pow/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
Q
loss/powPow
loss/users
loss/pow/y*
T0*
_output_shapes
:	�

]
loss/Const_1Const*
_output_shapes
:*
dtype0*
valueB"       
g

loss/Sum_2Sumloss/powloss/Const_1*
T0*

Tidx0*
_output_shapes
: *
	keep_dims( 
Q
loss/mul_1/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<
L

loss/mul_1Mulloss/mul_1/x
loss/Sum_2*
T0*
_output_shapes
: 
Q
loss/pow_1/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
Y

loss/pow_1Powloss/pos_itemsloss/pow_1/y*
T0*
_output_shapes
:	�

]
loss/Const_2Const*
_output_shapes
:*
dtype0*
valueB"       
i

loss/Sum_3Sum
loss/pow_1loss/Const_2*
T0*

Tidx0*
_output_shapes
: *
	keep_dims( 
Q
loss/mul_2/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<
L

loss/mul_2Mulloss/mul_2/x
loss/Sum_3*
T0*
_output_shapes
: 
Q
loss/pow_2/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
Y

loss/pow_2Powloss/pos_item_biasloss/pow_2/y*
T0*
_output_shapes	
:�
V
loss/Const_3Const*
_output_shapes
:*
dtype0*
valueB: 
i

loss/Sum_4Sum
loss/pow_2loss/Const_3*
T0*

Tidx0*
_output_shapes
: *
	keep_dims( 
J

loss/add_2Add
loss/mul_2
loss/Sum_4*
T0*
_output_shapes
: 
Q
loss/pow_3/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
Y

loss/pow_3Powloss/neg_itemsloss/pow_3/y*
T0*
_output_shapes
:	�

]
loss/Const_4Const*
_output_shapes
:*
dtype0*
valueB"       
i

loss/Sum_5Sum
loss/pow_3loss/Const_4*
T0*

Tidx0*
_output_shapes
: *
	keep_dims( 
Q
loss/mul_3/xConst*
_output_shapes
: *
dtype0*
valueB
 *
�#<
L

loss/mul_3Mulloss/mul_3/x
loss/Sum_5*
T0*
_output_shapes
: 
Q
loss/pow_4/yConst*
_output_shapes
: *
dtype0*
valueB
 *   @
Y

loss/pow_4Powloss/neg_item_biasloss/pow_4/y*
T0*
_output_shapes	
:�
V
loss/Const_5Const*
_output_shapes
:*
dtype0*
valueB: 
i

loss/Sum_6Sum
loss/pow_4loss/Const_5*
T0*

Tidx0*
_output_shapes
: *
	keep_dims( 
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
gradients/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
T
gradients/ConstConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
Y
gradients/FillFillgradients/Shapegradients/Const*
T0*
_output_shapes
: 
b
gradients/loss/sub_2_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/sub_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/sub_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_2_grad/Shape!gradients/loss/sub_2_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/sub_2_grad/SumSumgradients/Fill/gradients/loss/sub_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/sub_2_grad/ReshapeReshapegradients/loss/sub_2_grad/Sumgradients/loss/sub_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
�
gradients/loss/sub_2_grad/Sum_1Sumgradients/Fill1gradients/loss/sub_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
h
gradients/loss/sub_2_grad/NegNeggradients/loss/sub_2_grad/Sum_1*
T0*
_output_shapes
:
�
#gradients/loss/sub_2_grad/Reshape_1Reshapegradients/loss/sub_2_grad/Neg!gradients/loss/sub_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/sub_2_grad/tuple/group_depsNoOp"^gradients/loss/sub_2_grad/Reshape$^gradients/loss/sub_2_grad/Reshape_1
�
2gradients/loss/sub_2_grad/tuple/control_dependencyIdentity!gradients/loss/sub_2_grad/Reshape+^gradients/loss/sub_2_grad/tuple/group_deps*
T0*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/sub_2_grad/Reshape
�
4gradients/loss/sub_2_grad/tuple/control_dependency_1Identity#gradients/loss/sub_2_grad/Reshape_1+^gradients/loss/sub_2_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/sub_2_grad/Reshape_1
b
gradients/loss/add_5_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/add_5_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/add_5_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_5_grad/Shape!gradients/loss/add_5_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/add_5_grad/SumSum2gradients/loss/sub_2_grad/tuple/control_dependency/gradients/loss/add_5_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/add_5_grad/ReshapeReshapegradients/loss/add_5_grad/Sumgradients/loss/add_5_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
�
gradients/loss/add_5_grad/Sum_1Sum2gradients/loss/sub_2_grad/tuple/control_dependency1gradients/loss/add_5_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/add_5_grad/Reshape_1Reshapegradients/loss/add_5_grad/Sum_1!gradients/loss/add_5_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_5_grad/tuple/group_depsNoOp"^gradients/loss/add_5_grad/Reshape$^gradients/loss/add_5_grad/Reshape_1
�
2gradients/loss/add_5_grad/tuple/control_dependencyIdentity!gradients/loss/add_5_grad/Reshape+^gradients/loss/add_5_grad/tuple/group_deps*
T0*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/add_5_grad/Reshape
�
4gradients/loss/add_5_grad/tuple/control_dependency_1Identity#gradients/loss/add_5_grad/Reshape_1+^gradients/loss/add_5_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/add_5_grad/Reshape_1
q
'gradients/loss/Sum_1_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
�
!gradients/loss/Sum_1_grad/ReshapeReshape4gradients/loss/sub_2_grad/tuple/control_dependency_1'gradients/loss/Sum_1_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
s
(gradients/loss/Sum_1_grad/Tile/multiplesConst*
_output_shapes
:*
dtype0*
valueB:�
�
gradients/loss/Sum_1_grad/TileTile!gradients/loss/Sum_1_grad/Reshape(gradients/loss/Sum_1_grad/Tile/multiples*
T0*
_output_shapes	
:�*

Tmultiples0
b
gradients/loss/add_4_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/add_4_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/add_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_4_grad/Shape!gradients/loss/add_4_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/add_4_grad/SumSum2gradients/loss/add_5_grad/tuple/control_dependency/gradients/loss/add_4_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/add_4_grad/ReshapeReshapegradients/loss/add_4_grad/Sumgradients/loss/add_4_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
�
gradients/loss/add_4_grad/Sum_1Sum2gradients/loss/add_5_grad/tuple/control_dependency1gradients/loss/add_4_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/add_4_grad/Reshape_1Reshapegradients/loss/add_4_grad/Sum_1!gradients/loss/add_4_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_4_grad/tuple/group_depsNoOp"^gradients/loss/add_4_grad/Reshape$^gradients/loss/add_4_grad/Reshape_1
�
2gradients/loss/add_4_grad/tuple/control_dependencyIdentity!gradients/loss/add_4_grad/Reshape+^gradients/loss/add_4_grad/tuple/group_deps*
T0*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/add_4_grad/Reshape
�
4gradients/loss/add_4_grad/tuple/control_dependency_1Identity#gradients/loss/add_4_grad/Reshape_1+^gradients/loss/add_4_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/add_4_grad/Reshape_1
b
gradients/loss/add_3_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/add_3_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/add_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_3_grad/Shape!gradients/loss/add_3_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/add_3_grad/SumSum4gradients/loss/add_5_grad/tuple/control_dependency_1/gradients/loss/add_3_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/add_3_grad/ReshapeReshapegradients/loss/add_3_grad/Sumgradients/loss/add_3_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
�
gradients/loss/add_3_grad/Sum_1Sum4gradients/loss/add_5_grad/tuple/control_dependency_11gradients/loss/add_3_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/add_3_grad/Reshape_1Reshapegradients/loss/add_3_grad/Sum_1!gradients/loss/add_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_3_grad/tuple/group_depsNoOp"^gradients/loss/add_3_grad/Reshape$^gradients/loss/add_3_grad/Reshape_1
�
2gradients/loss/add_3_grad/tuple/control_dependencyIdentity!gradients/loss/add_3_grad/Reshape+^gradients/loss/add_3_grad/tuple/group_deps*
T0*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/add_3_grad/Reshape
�
4gradients/loss/add_3_grad/tuple/control_dependency_1Identity#gradients/loss/add_3_grad/Reshape_1+^gradients/loss/add_3_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/add_3_grad/Reshape_1
j
gradients/loss/Neg_1_grad/NegNeggradients/loss/Sum_1_grad/Tile*
T0*
_output_shapes	
:�
b
gradients/loss/mul_1_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/mul_1_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/mul_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_1_grad/Shape!gradients/loss/mul_1_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/mul_1_grad/mulMul2gradients/loss/add_4_grad/tuple/control_dependency
loss/Sum_2*
T0*
_output_shapes
: 
�
gradients/loss/mul_1_grad/SumSumgradients/loss/mul_1_grad/mul/gradients/loss/mul_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/mul_1_grad/ReshapeReshapegradients/loss/mul_1_grad/Sumgradients/loss/mul_1_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
�
gradients/loss/mul_1_grad/mul_1Mulloss/mul_1/x2gradients/loss/add_4_grad/tuple/control_dependency*
T0*
_output_shapes
: 
�
gradients/loss/mul_1_grad/Sum_1Sumgradients/loss/mul_1_grad/mul_11gradients/loss/mul_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/mul_1_grad/Reshape_1Reshapegradients/loss/mul_1_grad/Sum_1!gradients/loss/mul_1_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/mul_1_grad/tuple/group_depsNoOp"^gradients/loss/mul_1_grad/Reshape$^gradients/loss/mul_1_grad/Reshape_1
�
2gradients/loss/mul_1_grad/tuple/control_dependencyIdentity!gradients/loss/mul_1_grad/Reshape+^gradients/loss/mul_1_grad/tuple/group_deps*
T0*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/mul_1_grad/Reshape
�
4gradients/loss/mul_1_grad/tuple/control_dependency_1Identity#gradients/loss/mul_1_grad/Reshape_1+^gradients/loss/mul_1_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/mul_1_grad/Reshape_1
b
gradients/loss/add_2_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/add_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/add_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_2_grad/Shape!gradients/loss/add_2_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/add_2_grad/SumSum4gradients/loss/add_4_grad/tuple/control_dependency_1/gradients/loss/add_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/add_2_grad/ReshapeReshapegradients/loss/add_2_grad/Sumgradients/loss/add_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
�
gradients/loss/add_2_grad/Sum_1Sum4gradients/loss/add_4_grad/tuple/control_dependency_11gradients/loss/add_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/add_2_grad/Reshape_1Reshapegradients/loss/add_2_grad/Sum_1!gradients/loss/add_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/add_2_grad/tuple/group_depsNoOp"^gradients/loss/add_2_grad/Reshape$^gradients/loss/add_2_grad/Reshape_1
�
2gradients/loss/add_2_grad/tuple/control_dependencyIdentity!gradients/loss/add_2_grad/Reshape+^gradients/loss/add_2_grad/tuple/group_deps*
T0*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/add_2_grad/Reshape
�
4gradients/loss/add_2_grad/tuple/control_dependency_1Identity#gradients/loss/add_2_grad/Reshape_1+^gradients/loss/add_2_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/add_2_grad/Reshape_1
b
gradients/loss/mul_3_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/mul_3_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/mul_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_3_grad/Shape!gradients/loss/mul_3_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/mul_3_grad/mulMul2gradients/loss/add_3_grad/tuple/control_dependency
loss/Sum_5*
T0*
_output_shapes
: 
�
gradients/loss/mul_3_grad/SumSumgradients/loss/mul_3_grad/mul/gradients/loss/mul_3_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/mul_3_grad/ReshapeReshapegradients/loss/mul_3_grad/Sumgradients/loss/mul_3_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
�
gradients/loss/mul_3_grad/mul_1Mulloss/mul_3/x2gradients/loss/add_3_grad/tuple/control_dependency*
T0*
_output_shapes
: 
�
gradients/loss/mul_3_grad/Sum_1Sumgradients/loss/mul_3_grad/mul_11gradients/loss/mul_3_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/mul_3_grad/Reshape_1Reshapegradients/loss/mul_3_grad/Sum_1!gradients/loss/mul_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/mul_3_grad/tuple/group_depsNoOp"^gradients/loss/mul_3_grad/Reshape$^gradients/loss/mul_3_grad/Reshape_1
�
2gradients/loss/mul_3_grad/tuple/control_dependencyIdentity!gradients/loss/mul_3_grad/Reshape+^gradients/loss/mul_3_grad/tuple/group_deps*
T0*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/mul_3_grad/Reshape
�
4gradients/loss/mul_3_grad/tuple/control_dependency_1Identity#gradients/loss/mul_3_grad/Reshape_1+^gradients/loss/mul_3_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/mul_3_grad/Reshape_1
q
'gradients/loss/Sum_6_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
�
!gradients/loss/Sum_6_grad/ReshapeReshape4gradients/loss/add_3_grad/tuple/control_dependency_1'gradients/loss/Sum_6_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
s
(gradients/loss/Sum_6_grad/Tile/multiplesConst*
_output_shapes
:*
dtype0*
valueB:�
�
gradients/loss/Sum_6_grad/TileTile!gradients/loss/Sum_6_grad/Reshape(gradients/loss/Sum_6_grad/Tile/multiples*
T0*
_output_shapes	
:�*

Tmultiples0
�
"gradients/loss/Log_grad/Reciprocal
Reciprocal
loss/add_1^gradients/loss/Neg_1_grad/Neg*
T0*
_output_shapes	
:�
�
gradients/loss/Log_grad/mulMulgradients/loss/Neg_1_grad/Neg"gradients/loss/Log_grad/Reciprocal*
T0*
_output_shapes	
:�
x
'gradients/loss/Sum_2_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"      
�
!gradients/loss/Sum_2_grad/ReshapeReshape4gradients/loss/mul_1_grad/tuple/control_dependency_1'gradients/loss/Sum_2_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
y
(gradients/loss/Sum_2_grad/Tile/multiplesConst*
_output_shapes
:*
dtype0*
valueB"�   
   
�
gradients/loss/Sum_2_grad/TileTile!gradients/loss/Sum_2_grad/Reshape(gradients/loss/Sum_2_grad/Tile/multiples*
T0*
_output_shapes
:	�
*

Tmultiples0
b
gradients/loss/mul_2_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
d
!gradients/loss/mul_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/mul_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_2_grad/Shape!gradients/loss/mul_2_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/mul_2_grad/mulMul2gradients/loss/add_2_grad/tuple/control_dependency
loss/Sum_3*
T0*
_output_shapes
: 
�
gradients/loss/mul_2_grad/SumSumgradients/loss/mul_2_grad/mul/gradients/loss/mul_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/mul_2_grad/ReshapeReshapegradients/loss/mul_2_grad/Sumgradients/loss/mul_2_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
�
gradients/loss/mul_2_grad/mul_1Mulloss/mul_2/x2gradients/loss/add_2_grad/tuple/control_dependency*
T0*
_output_shapes
: 
�
gradients/loss/mul_2_grad/Sum_1Sumgradients/loss/mul_2_grad/mul_11gradients/loss/mul_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/mul_2_grad/Reshape_1Reshapegradients/loss/mul_2_grad/Sum_1!gradients/loss/mul_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/mul_2_grad/tuple/group_depsNoOp"^gradients/loss/mul_2_grad/Reshape$^gradients/loss/mul_2_grad/Reshape_1
�
2gradients/loss/mul_2_grad/tuple/control_dependencyIdentity!gradients/loss/mul_2_grad/Reshape+^gradients/loss/mul_2_grad/tuple/group_deps*
T0*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/mul_2_grad/Reshape
�
4gradients/loss/mul_2_grad/tuple/control_dependency_1Identity#gradients/loss/mul_2_grad/Reshape_1+^gradients/loss/mul_2_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/mul_2_grad/Reshape_1
q
'gradients/loss/Sum_4_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB:
�
!gradients/loss/Sum_4_grad/ReshapeReshape4gradients/loss/add_2_grad/tuple/control_dependency_1'gradients/loss/Sum_4_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes
:
s
(gradients/loss/Sum_4_grad/Tile/multiplesConst*
_output_shapes
:*
dtype0*
valueB:�
�
gradients/loss/Sum_4_grad/TileTile!gradients/loss/Sum_4_grad/Reshape(gradients/loss/Sum_4_grad/Tile/multiples*
T0*
_output_shapes	
:�*

Tmultiples0
x
'gradients/loss/Sum_5_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"      
�
!gradients/loss/Sum_5_grad/ReshapeReshape4gradients/loss/mul_3_grad/tuple/control_dependency_1'gradients/loss/Sum_5_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
y
(gradients/loss/Sum_5_grad/Tile/multiplesConst*
_output_shapes
:*
dtype0*
valueB"�   
   
�
gradients/loss/Sum_5_grad/TileTile!gradients/loss/Sum_5_grad/Reshape(gradients/loss/Sum_5_grad/Tile/multiples*
T0*
_output_shapes
:	�
*

Tmultiples0
j
gradients/loss/pow_4_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB:�
d
!gradients/loss/pow_4_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/pow_4_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_4_grad/Shape!gradients/loss/pow_4_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
x
gradients/loss/pow_4_grad/mulMulgradients/loss/Sum_6_grad/Tileloss/pow_4/y*
T0*
_output_shapes	
:�
d
gradients/loss/pow_4_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
t
gradients/loss/pow_4_grad/subSubloss/pow_4/ygradients/loss/pow_4_grad/sub/y*
T0*
_output_shapes
: 
}
gradients/loss/pow_4_grad/PowPowloss/neg_item_biasgradients/loss/pow_4_grad/sub*
T0*
_output_shapes	
:�
�
gradients/loss/pow_4_grad/mul_1Mulgradients/loss/pow_4_grad/mulgradients/loss/pow_4_grad/Pow*
T0*
_output_shapes	
:�
�
gradients/loss/pow_4_grad/SumSumgradients/loss/pow_4_grad/mul_1/gradients/loss/pow_4_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/pow_4_grad/ReshapeReshapegradients/loss/pow_4_grad/Sumgradients/loss/pow_4_grad/Shape*
T0*
Tshape0*
_output_shapes	
:�
h
#gradients/loss/pow_4_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
!gradients/loss/pow_4_grad/GreaterGreaterloss/neg_item_bias#gradients/loss/pow_4_grad/Greater/y*
T0*
_output_shapes	
:�
^
gradients/loss/pow_4_grad/LogLogloss/neg_item_bias*
T0*
_output_shapes	
:�
k
$gradients/loss/pow_4_grad/zeros_like	ZerosLikeloss/neg_item_bias*
T0*
_output_shapes	
:�
�
 gradients/loss/pow_4_grad/SelectSelect!gradients/loss/pow_4_grad/Greatergradients/loss/pow_4_grad/Log$gradients/loss/pow_4_grad/zeros_like*
T0*
_output_shapes	
:�
x
gradients/loss/pow_4_grad/mul_2Mulgradients/loss/Sum_6_grad/Tile
loss/pow_4*
T0*
_output_shapes	
:�
�
gradients/loss/pow_4_grad/mul_3Mulgradients/loss/pow_4_grad/mul_2 gradients/loss/pow_4_grad/Select*
T0*
_output_shapes	
:�
�
gradients/loss/pow_4_grad/Sum_1Sumgradients/loss/pow_4_grad/mul_31gradients/loss/pow_4_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/pow_4_grad/Reshape_1Reshapegradients/loss/pow_4_grad/Sum_1!gradients/loss/pow_4_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_4_grad/tuple/group_depsNoOp"^gradients/loss/pow_4_grad/Reshape$^gradients/loss/pow_4_grad/Reshape_1
�
2gradients/loss/pow_4_grad/tuple/control_dependencyIdentity!gradients/loss/pow_4_grad/Reshape+^gradients/loss/pow_4_grad/tuple/group_deps*
T0*
_output_shapes	
:�*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape
�
4gradients/loss/pow_4_grad/tuple/control_dependency_1Identity#gradients/loss/pow_4_grad/Reshape_1+^gradients/loss/pow_4_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/pow_4_grad/Reshape_1
b
gradients/loss/add_1_grad/ShapeConst*
_output_shapes
: *
dtype0*
valueB 
l
!gradients/loss/add_1_grad/Shape_1Const*
_output_shapes
:*
dtype0*
valueB:�
�
/gradients/loss/add_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_1_grad/Shape!gradients/loss/add_1_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/add_1_grad/SumSumgradients/loss/Log_grad/mul/gradients/loss/add_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/add_1_grad/ReshapeReshapegradients/loss/add_1_grad/Sumgradients/loss/add_1_grad/Shape*
T0*
Tshape0*
_output_shapes
: 
�
gradients/loss/add_1_grad/Sum_1Sumgradients/loss/Log_grad/mul1gradients/loss/add_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/add_1_grad/Reshape_1Reshapegradients/loss/add_1_grad/Sum_1!gradients/loss/add_1_grad/Shape_1*
T0*
Tshape0*
_output_shapes	
:�
|
*gradients/loss/add_1_grad/tuple/group_depsNoOp"^gradients/loss/add_1_grad/Reshape$^gradients/loss/add_1_grad/Reshape_1
�
2gradients/loss/add_1_grad/tuple/control_dependencyIdentity!gradients/loss/add_1_grad/Reshape+^gradients/loss/add_1_grad/tuple/group_deps*
T0*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/add_1_grad/Reshape
�
4gradients/loss/add_1_grad/tuple/control_dependency_1Identity#gradients/loss/add_1_grad/Reshape_1+^gradients/loss/add_1_grad/tuple/group_deps*
T0*
_output_shapes	
:�*6
_class,
*(loc:@gradients/loss/add_1_grad/Reshape_1
n
gradients/loss/pow_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"�   
   
b
gradients/loss/pow_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
-gradients/loss/pow_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_grad/Shapegradients/loss/pow_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
x
gradients/loss/pow_grad/mulMulgradients/loss/Sum_2_grad/Tile
loss/pow/y*
T0*
_output_shapes
:	�

b
gradients/loss/pow_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
n
gradients/loss/pow_grad/subSub
loss/pow/ygradients/loss/pow_grad/sub/y*
T0*
_output_shapes
: 
u
gradients/loss/pow_grad/PowPow
loss/usersgradients/loss/pow_grad/sub*
T0*
_output_shapes
:	�

�
gradients/loss/pow_grad/mul_1Mulgradients/loss/pow_grad/mulgradients/loss/pow_grad/Pow*
T0*
_output_shapes
:	�

�
gradients/loss/pow_grad/SumSumgradients/loss/pow_grad/mul_1-gradients/loss/pow_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
gradients/loss/pow_grad/ReshapeReshapegradients/loss/pow_grad/Sumgradients/loss/pow_grad/Shape*
T0*
Tshape0*
_output_shapes
:	�

f
!gradients/loss/pow_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
gradients/loss/pow_grad/GreaterGreater
loss/users!gradients/loss/pow_grad/Greater/y*
T0*
_output_shapes
:	�

X
gradients/loss/pow_grad/LogLog
loss/users*
T0*
_output_shapes
:	�

e
"gradients/loss/pow_grad/zeros_like	ZerosLike
loss/users*
T0*
_output_shapes
:	�

�
gradients/loss/pow_grad/SelectSelectgradients/loss/pow_grad/Greatergradients/loss/pow_grad/Log"gradients/loss/pow_grad/zeros_like*
T0*
_output_shapes
:	�

x
gradients/loss/pow_grad/mul_2Mulgradients/loss/Sum_2_grad/Tileloss/pow*
T0*
_output_shapes
:	�

�
gradients/loss/pow_grad/mul_3Mulgradients/loss/pow_grad/mul_2gradients/loss/pow_grad/Select*
T0*
_output_shapes
:	�

�
gradients/loss/pow_grad/Sum_1Sumgradients/loss/pow_grad/mul_3/gradients/loss/pow_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/pow_grad/Reshape_1Reshapegradients/loss/pow_grad/Sum_1gradients/loss/pow_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
v
(gradients/loss/pow_grad/tuple/group_depsNoOp ^gradients/loss/pow_grad/Reshape"^gradients/loss/pow_grad/Reshape_1
�
0gradients/loss/pow_grad/tuple/control_dependencyIdentitygradients/loss/pow_grad/Reshape)^gradients/loss/pow_grad/tuple/group_deps*
T0*
_output_shapes
:	�
*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape
�
2gradients/loss/pow_grad/tuple/control_dependency_1Identity!gradients/loss/pow_grad/Reshape_1)^gradients/loss/pow_grad/tuple/group_deps*
T0*
_output_shapes
: *4
_class*
(&loc:@gradients/loss/pow_grad/Reshape_1
x
'gradients/loss/Sum_3_grad/Reshape/shapeConst*
_output_shapes
:*
dtype0*
valueB"      
�
!gradients/loss/Sum_3_grad/ReshapeReshape4gradients/loss/mul_2_grad/tuple/control_dependency_1'gradients/loss/Sum_3_grad/Reshape/shape*
T0*
Tshape0*
_output_shapes

:
y
(gradients/loss/Sum_3_grad/Tile/multiplesConst*
_output_shapes
:*
dtype0*
valueB"�   
   
�
gradients/loss/Sum_3_grad/TileTile!gradients/loss/Sum_3_grad/Reshape(gradients/loss/Sum_3_grad/Tile/multiples*
T0*
_output_shapes
:	�
*

Tmultiples0
j
gradients/loss/pow_2_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB:�
d
!gradients/loss/pow_2_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/pow_2_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_2_grad/Shape!gradients/loss/pow_2_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
x
gradients/loss/pow_2_grad/mulMulgradients/loss/Sum_4_grad/Tileloss/pow_2/y*
T0*
_output_shapes	
:�
d
gradients/loss/pow_2_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
t
gradients/loss/pow_2_grad/subSubloss/pow_2/ygradients/loss/pow_2_grad/sub/y*
T0*
_output_shapes
: 
}
gradients/loss/pow_2_grad/PowPowloss/pos_item_biasgradients/loss/pow_2_grad/sub*
T0*
_output_shapes	
:�
�
gradients/loss/pow_2_grad/mul_1Mulgradients/loss/pow_2_grad/mulgradients/loss/pow_2_grad/Pow*
T0*
_output_shapes	
:�
�
gradients/loss/pow_2_grad/SumSumgradients/loss/pow_2_grad/mul_1/gradients/loss/pow_2_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/pow_2_grad/ReshapeReshapegradients/loss/pow_2_grad/Sumgradients/loss/pow_2_grad/Shape*
T0*
Tshape0*
_output_shapes	
:�
h
#gradients/loss/pow_2_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
!gradients/loss/pow_2_grad/GreaterGreaterloss/pos_item_bias#gradients/loss/pow_2_grad/Greater/y*
T0*
_output_shapes	
:�
^
gradients/loss/pow_2_grad/LogLogloss/pos_item_bias*
T0*
_output_shapes	
:�
k
$gradients/loss/pow_2_grad/zeros_like	ZerosLikeloss/pos_item_bias*
T0*
_output_shapes	
:�
�
 gradients/loss/pow_2_grad/SelectSelect!gradients/loss/pow_2_grad/Greatergradients/loss/pow_2_grad/Log$gradients/loss/pow_2_grad/zeros_like*
T0*
_output_shapes	
:�
x
gradients/loss/pow_2_grad/mul_2Mulgradients/loss/Sum_4_grad/Tile
loss/pow_2*
T0*
_output_shapes	
:�
�
gradients/loss/pow_2_grad/mul_3Mulgradients/loss/pow_2_grad/mul_2 gradients/loss/pow_2_grad/Select*
T0*
_output_shapes	
:�
�
gradients/loss/pow_2_grad/Sum_1Sumgradients/loss/pow_2_grad/mul_31gradients/loss/pow_2_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/pow_2_grad/Reshape_1Reshapegradients/loss/pow_2_grad/Sum_1!gradients/loss/pow_2_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_2_grad/tuple/group_depsNoOp"^gradients/loss/pow_2_grad/Reshape$^gradients/loss/pow_2_grad/Reshape_1
�
2gradients/loss/pow_2_grad/tuple/control_dependencyIdentity!gradients/loss/pow_2_grad/Reshape+^gradients/loss/pow_2_grad/tuple/group_deps*
T0*
_output_shapes	
:�*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape
�
4gradients/loss/pow_2_grad/tuple/control_dependency_1Identity#gradients/loss/pow_2_grad/Reshape_1+^gradients/loss/pow_2_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/pow_2_grad/Reshape_1
p
gradients/loss/pow_3_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"�   
   
d
!gradients/loss/pow_3_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/pow_3_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_3_grad/Shape!gradients/loss/pow_3_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
|
gradients/loss/pow_3_grad/mulMulgradients/loss/Sum_5_grad/Tileloss/pow_3/y*
T0*
_output_shapes
:	�

d
gradients/loss/pow_3_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
t
gradients/loss/pow_3_grad/subSubloss/pow_3/ygradients/loss/pow_3_grad/sub/y*
T0*
_output_shapes
: 
}
gradients/loss/pow_3_grad/PowPowloss/neg_itemsgradients/loss/pow_3_grad/sub*
T0*
_output_shapes
:	�

�
gradients/loss/pow_3_grad/mul_1Mulgradients/loss/pow_3_grad/mulgradients/loss/pow_3_grad/Pow*
T0*
_output_shapes
:	�

�
gradients/loss/pow_3_grad/SumSumgradients/loss/pow_3_grad/mul_1/gradients/loss/pow_3_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/pow_3_grad/ReshapeReshapegradients/loss/pow_3_grad/Sumgradients/loss/pow_3_grad/Shape*
T0*
Tshape0*
_output_shapes
:	�

h
#gradients/loss/pow_3_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
!gradients/loss/pow_3_grad/GreaterGreaterloss/neg_items#gradients/loss/pow_3_grad/Greater/y*
T0*
_output_shapes
:	�

^
gradients/loss/pow_3_grad/LogLogloss/neg_items*
T0*
_output_shapes
:	�

k
$gradients/loss/pow_3_grad/zeros_like	ZerosLikeloss/neg_items*
T0*
_output_shapes
:	�

�
 gradients/loss/pow_3_grad/SelectSelect!gradients/loss/pow_3_grad/Greatergradients/loss/pow_3_grad/Log$gradients/loss/pow_3_grad/zeros_like*
T0*
_output_shapes
:	�

|
gradients/loss/pow_3_grad/mul_2Mulgradients/loss/Sum_5_grad/Tile
loss/pow_3*
T0*
_output_shapes
:	�

�
gradients/loss/pow_3_grad/mul_3Mulgradients/loss/pow_3_grad/mul_2 gradients/loss/pow_3_grad/Select*
T0*
_output_shapes
:	�

�
gradients/loss/pow_3_grad/Sum_1Sumgradients/loss/pow_3_grad/mul_31gradients/loss/pow_3_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/pow_3_grad/Reshape_1Reshapegradients/loss/pow_3_grad/Sum_1!gradients/loss/pow_3_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_3_grad/tuple/group_depsNoOp"^gradients/loss/pow_3_grad/Reshape$^gradients/loss/pow_3_grad/Reshape_1
�
2gradients/loss/pow_3_grad/tuple/control_dependencyIdentity!gradients/loss/pow_3_grad/Reshape+^gradients/loss/pow_3_grad/tuple/group_deps*
T0*
_output_shapes
:	�
*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape
�
4gradients/loss/pow_3_grad/tuple/control_dependency_1Identity#gradients/loss/pow_3_grad/Reshape_1+^gradients/loss/pow_3_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/pow_3_grad/Reshape_1
�
gradients/loss/Exp_grad/mulMul4gradients/loss/add_1_grad/tuple/control_dependency_1loss/Exp*
T0*
_output_shapes	
:�
p
gradients/loss/pow_1_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"�   
   
d
!gradients/loss/pow_1_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
�
/gradients/loss/pow_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/pow_1_grad/Shape!gradients/loss/pow_1_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
|
gradients/loss/pow_1_grad/mulMulgradients/loss/Sum_3_grad/Tileloss/pow_1/y*
T0*
_output_shapes
:	�

d
gradients/loss/pow_1_grad/sub/yConst*
_output_shapes
: *
dtype0*
valueB
 *  �?
t
gradients/loss/pow_1_grad/subSubloss/pow_1/ygradients/loss/pow_1_grad/sub/y*
T0*
_output_shapes
: 
}
gradients/loss/pow_1_grad/PowPowloss/pos_itemsgradients/loss/pow_1_grad/sub*
T0*
_output_shapes
:	�

�
gradients/loss/pow_1_grad/mul_1Mulgradients/loss/pow_1_grad/mulgradients/loss/pow_1_grad/Pow*
T0*
_output_shapes
:	�

�
gradients/loss/pow_1_grad/SumSumgradients/loss/pow_1_grad/mul_1/gradients/loss/pow_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/pow_1_grad/ReshapeReshapegradients/loss/pow_1_grad/Sumgradients/loss/pow_1_grad/Shape*
T0*
Tshape0*
_output_shapes
:	�

h
#gradients/loss/pow_1_grad/Greater/yConst*
_output_shapes
: *
dtype0*
valueB
 *    
�
!gradients/loss/pow_1_grad/GreaterGreaterloss/pos_items#gradients/loss/pow_1_grad/Greater/y*
T0*
_output_shapes
:	�

^
gradients/loss/pow_1_grad/LogLogloss/pos_items*
T0*
_output_shapes
:	�

k
$gradients/loss/pow_1_grad/zeros_like	ZerosLikeloss/pos_items*
T0*
_output_shapes
:	�

�
 gradients/loss/pow_1_grad/SelectSelect!gradients/loss/pow_1_grad/Greatergradients/loss/pow_1_grad/Log$gradients/loss/pow_1_grad/zeros_like*
T0*
_output_shapes
:	�

|
gradients/loss/pow_1_grad/mul_2Mulgradients/loss/Sum_3_grad/Tile
loss/pow_1*
T0*
_output_shapes
:	�

�
gradients/loss/pow_1_grad/mul_3Mulgradients/loss/pow_1_grad/mul_2 gradients/loss/pow_1_grad/Select*
T0*
_output_shapes
:	�

�
gradients/loss/pow_1_grad/Sum_1Sumgradients/loss/pow_1_grad/mul_31gradients/loss/pow_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
#gradients/loss/pow_1_grad/Reshape_1Reshapegradients/loss/pow_1_grad/Sum_1!gradients/loss/pow_1_grad/Shape_1*
T0*
Tshape0*
_output_shapes
: 
|
*gradients/loss/pow_1_grad/tuple/group_depsNoOp"^gradients/loss/pow_1_grad/Reshape$^gradients/loss/pow_1_grad/Reshape_1
�
2gradients/loss/pow_1_grad/tuple/control_dependencyIdentity!gradients/loss/pow_1_grad/Reshape+^gradients/loss/pow_1_grad/tuple/group_deps*
T0*
_output_shapes
:	�
*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape
�
4gradients/loss/pow_1_grad/tuple/control_dependency_1Identity#gradients/loss/pow_1_grad/Reshape_1+^gradients/loss/pow_1_grad/tuple/group_deps*
T0*
_output_shapes
: *6
_class,
*(loc:@gradients/loss/pow_1_grad/Reshape_1
e
gradients/loss/Neg_grad/NegNeggradients/loss/Exp_grad/mul*
T0*
_output_shapes	
:�
h
gradients/loss/add_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB:�
j
gradients/loss/add_grad/Shape_1Const*
_output_shapes
:*
dtype0*
valueB:�
�
-gradients/loss/add_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/add_grad/Shapegradients/loss/add_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/add_grad/SumSumgradients/loss/Neg_grad/Neg-gradients/loss/add_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
gradients/loss/add_grad/ReshapeReshapegradients/loss/add_grad/Sumgradients/loss/add_grad/Shape*
T0*
Tshape0*
_output_shapes	
:�
�
gradients/loss/add_grad/Sum_1Sumgradients/loss/Neg_grad/Neg/gradients/loss/add_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/add_grad/Reshape_1Reshapegradients/loss/add_grad/Sum_1gradients/loss/add_grad/Shape_1*
T0*
Tshape0*
_output_shapes	
:�
v
(gradients/loss/add_grad/tuple/group_depsNoOp ^gradients/loss/add_grad/Reshape"^gradients/loss/add_grad/Reshape_1
�
0gradients/loss/add_grad/tuple/control_dependencyIdentitygradients/loss/add_grad/Reshape)^gradients/loss/add_grad/tuple/group_deps*
T0*
_output_shapes	
:�*2
_class(
&$loc:@gradients/loss/add_grad/Reshape
�
2gradients/loss/add_grad/tuple/control_dependency_1Identity!gradients/loss/add_grad/Reshape_1)^gradients/loss/add_grad/tuple/group_deps*
T0*
_output_shapes	
:�*4
_class*
(&loc:@gradients/loss/add_grad/Reshape_1
j
gradients/loss/sub_1_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB:�
l
!gradients/loss/sub_1_grad/Shape_1Const*
_output_shapes
:*
dtype0*
valueB:�
�
/gradients/loss/sub_1_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_1_grad/Shape!gradients/loss/sub_1_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/sub_1_grad/SumSum0gradients/loss/add_grad/tuple/control_dependency/gradients/loss/sub_1_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/sub_1_grad/ReshapeReshapegradients/loss/sub_1_grad/Sumgradients/loss/sub_1_grad/Shape*
T0*
Tshape0*
_output_shapes	
:�
�
gradients/loss/sub_1_grad/Sum_1Sum0gradients/loss/add_grad/tuple/control_dependency1gradients/loss/sub_1_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
h
gradients/loss/sub_1_grad/NegNeggradients/loss/sub_1_grad/Sum_1*
T0*
_output_shapes
:
�
#gradients/loss/sub_1_grad/Reshape_1Reshapegradients/loss/sub_1_grad/Neg!gradients/loss/sub_1_grad/Shape_1*
T0*
Tshape0*
_output_shapes	
:�
|
*gradients/loss/sub_1_grad/tuple/group_depsNoOp"^gradients/loss/sub_1_grad/Reshape$^gradients/loss/sub_1_grad/Reshape_1
�
2gradients/loss/sub_1_grad/tuple/control_dependencyIdentity!gradients/loss/sub_1_grad/Reshape+^gradients/loss/sub_1_grad/tuple/group_deps*
T0*
_output_shapes	
:�*4
_class*
(&loc:@gradients/loss/sub_1_grad/Reshape
�
4gradients/loss/sub_1_grad/tuple/control_dependency_1Identity#gradients/loss/sub_1_grad/Reshape_1+^gradients/loss/sub_1_grad/tuple/group_deps*
T0*
_output_shapes	
:�*6
_class,
*(loc:@gradients/loss/sub_1_grad/Reshape_1
n
gradients/loss/Sum_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"�   
   
^
gradients/loss/Sum_grad/SizeConst*
_output_shapes
: *
dtype0*
value	B :
}
gradients/loss/Sum_grad/addAddloss/Sum/reduction_indicesgradients/loss/Sum_grad/Size*
T0*
_output_shapes
: 
�
gradients/loss/Sum_grad/modFloorModgradients/loss/Sum_grad/addgradients/loss/Sum_grad/Size*
T0*
_output_shapes
: 
b
gradients/loss/Sum_grad/Shape_1Const*
_output_shapes
: *
dtype0*
valueB 
e
#gradients/loss/Sum_grad/range/startConst*
_output_shapes
: *
dtype0*
value	B : 
e
#gradients/loss/Sum_grad/range/deltaConst*
_output_shapes
: *
dtype0*
value	B :
�
gradients/loss/Sum_grad/rangeRange#gradients/loss/Sum_grad/range/startgradients/loss/Sum_grad/Size#gradients/loss/Sum_grad/range/delta*

Tidx0*
_output_shapes
:
d
"gradients/loss/Sum_grad/Fill/valueConst*
_output_shapes
: *
dtype0*
value	B :
�
gradients/loss/Sum_grad/FillFillgradients/loss/Sum_grad/Shape_1"gradients/loss/Sum_grad/Fill/value*
T0*
_output_shapes
: 
�
%gradients/loss/Sum_grad/DynamicStitchDynamicStitchgradients/loss/Sum_grad/rangegradients/loss/Sum_grad/modgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Fill*
T0*#
_output_shapes
:���������*
N
c
!gradients/loss/Sum_grad/Maximum/yConst*
_output_shapes
: *
dtype0*
value	B :
�
gradients/loss/Sum_grad/MaximumMaximum%gradients/loss/Sum_grad/DynamicStitch!gradients/loss/Sum_grad/Maximum/y*
T0*#
_output_shapes
:���������
�
 gradients/loss/Sum_grad/floordivFloorDivgradients/loss/Sum_grad/Shapegradients/loss/Sum_grad/Maximum*
T0*
_output_shapes
:
�
gradients/loss/Sum_grad/ReshapeReshape2gradients/loss/add_grad/tuple/control_dependency_1%gradients/loss/Sum_grad/DynamicStitch*
T0*
Tshape0*
_output_shapes
:
�
gradients/loss/Sum_grad/TileTilegradients/loss/Sum_grad/Reshape gradients/loss/Sum_grad/floordiv*
T0*
_output_shapes
:	�
*

Tmultiples0
�
gradients/AddNAddN2gradients/loss/pow_2_grad/tuple/control_dependency2gradients/loss/sub_1_grad/tuple/control_dependency*
T0*
_output_shapes	
:�*
N*4
_class*
(&loc:@gradients/loss/pow_2_grad/Reshape
�
'gradients/loss/pos_item_bias_grad/ShapeConst*&
_class
loc:@variables/item_bias*
_output_shapes
:*
dtype0*
valueB:�
i
&gradients/loss/pos_item_bias_grad/SizeConst*
_output_shapes
: *
dtype0*
value
B :�
r
0gradients/loss/pos_item_bias_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
,gradients/loss/pos_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/pos_item_bias_grad/Size0gradients/loss/pos_item_bias_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:

5gradients/loss/pos_item_bias_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
�
7gradients/loss/pos_item_bias_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
�
7gradients/loss/pos_item_bias_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
/gradients/loss/pos_item_bias_grad/strided_sliceStridedSlice'gradients/loss/pos_item_bias_grad/Shape5gradients/loss/pos_item_bias_grad/strided_slice/stack7gradients/loss/pos_item_bias_grad/strided_slice/stack_17gradients/loss/pos_item_bias_grad/strided_slice/stack_2*
Index0*
shrink_axis_mask *
end_mask*
new_axis_mask *
ellipsis_mask *

begin_mask *
T0*
_output_shapes
: 
o
-gradients/loss/pos_item_bias_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
(gradients/loss/pos_item_bias_grad/concatConcatV2,gradients/loss/pos_item_bias_grad/ExpandDims/gradients/loss/pos_item_bias_grad/strided_slice-gradients/loss/pos_item_bias_grad/concat/axis*
T0*

Tidx0*
N*
_output_shapes
:
�
)gradients/loss/pos_item_bias_grad/ReshapeReshapegradients/AddN(gradients/loss/pos_item_bias_grad/concat*
T0*
Tshape0*
_output_shapes	
:�
�
+gradients/loss/pos_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_pos_items,gradients/loss/pos_item_bias_grad/ExpandDims*
T0*
Tshape0*
_output_shapes	
:�
�
gradients/AddN_1AddN2gradients/loss/pow_4_grad/tuple/control_dependency4gradients/loss/sub_1_grad/tuple/control_dependency_1*
T0*
_output_shapes	
:�*
N*4
_class*
(&loc:@gradients/loss/pow_4_grad/Reshape
�
'gradients/loss/neg_item_bias_grad/ShapeConst*&
_class
loc:@variables/item_bias*
_output_shapes
:*
dtype0*
valueB:�
i
&gradients/loss/neg_item_bias_grad/SizeConst*
_output_shapes
: *
dtype0*
value
B :�
r
0gradients/loss/neg_item_bias_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
,gradients/loss/neg_item_bias_grad/ExpandDims
ExpandDims&gradients/loss/neg_item_bias_grad/Size0gradients/loss/neg_item_bias_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:

5gradients/loss/neg_item_bias_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
�
7gradients/loss/neg_item_bias_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
�
7gradients/loss/neg_item_bias_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
/gradients/loss/neg_item_bias_grad/strided_sliceStridedSlice'gradients/loss/neg_item_bias_grad/Shape5gradients/loss/neg_item_bias_grad/strided_slice/stack7gradients/loss/neg_item_bias_grad/strided_slice/stack_17gradients/loss/neg_item_bias_grad/strided_slice/stack_2*
Index0*
shrink_axis_mask *
end_mask*
new_axis_mask *
ellipsis_mask *

begin_mask *
T0*
_output_shapes
: 
o
-gradients/loss/neg_item_bias_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
(gradients/loss/neg_item_bias_grad/concatConcatV2,gradients/loss/neg_item_bias_grad/ExpandDims/gradients/loss/neg_item_bias_grad/strided_slice-gradients/loss/neg_item_bias_grad/concat/axis*
T0*

Tidx0*
N*
_output_shapes
:
�
)gradients/loss/neg_item_bias_grad/ReshapeReshapegradients/AddN_1(gradients/loss/neg_item_bias_grad/concat*
T0*
Tshape0*
_output_shapes	
:�
�
+gradients/loss/neg_item_bias_grad/Reshape_1Reshapeplaceholders/sampled_neg_items,gradients/loss/neg_item_bias_grad/ExpandDims*
T0*
Tshape0*
_output_shapes	
:�
n
gradients/loss/mul_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"�   
   
p
gradients/loss/mul_grad/Shape_1Const*
_output_shapes
:*
dtype0*
valueB"�   
   
�
-gradients/loss/mul_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/mul_grad/Shapegradients/loss/mul_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
t
gradients/loss/mul_grad/mulMulgradients/loss/Sum_grad/Tileloss/sub*
T0*
_output_shapes
:	�

�
gradients/loss/mul_grad/SumSumgradients/loss/mul_grad/mul-gradients/loss/mul_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
gradients/loss/mul_grad/ReshapeReshapegradients/loss/mul_grad/Sumgradients/loss/mul_grad/Shape*
T0*
Tshape0*
_output_shapes
:	�

x
gradients/loss/mul_grad/mul_1Mul
loss/usersgradients/loss/Sum_grad/Tile*
T0*
_output_shapes
:	�

�
gradients/loss/mul_grad/Sum_1Sumgradients/loss/mul_grad/mul_1/gradients/loss/mul_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
!gradients/loss/mul_grad/Reshape_1Reshapegradients/loss/mul_grad/Sum_1gradients/loss/mul_grad/Shape_1*
T0*
Tshape0*
_output_shapes
:	�

v
(gradients/loss/mul_grad/tuple/group_depsNoOp ^gradients/loss/mul_grad/Reshape"^gradients/loss/mul_grad/Reshape_1
�
0gradients/loss/mul_grad/tuple/control_dependencyIdentitygradients/loss/mul_grad/Reshape)^gradients/loss/mul_grad/tuple/group_deps*
T0*
_output_shapes
:	�
*2
_class(
&$loc:@gradients/loss/mul_grad/Reshape
�
2gradients/loss/mul_grad/tuple/control_dependency_1Identity!gradients/loss/mul_grad/Reshape_1)^gradients/loss/mul_grad/tuple/group_deps*
T0*
_output_shapes
:	�
*4
_class*
(&loc:@gradients/loss/mul_grad/Reshape_1
W
gradients/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients/concatConcatV2)gradients/loss/pos_item_bias_grad/Reshape)gradients/loss/neg_item_bias_grad/Reshapegradients/concat/axis*
T0*

Tidx0*
N*
_output_shapes	
:�
Y
gradients/concat_1/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients/concat_1ConcatV2+gradients/loss/pos_item_bias_grad/Reshape_1+gradients/loss/neg_item_bias_grad/Reshape_1gradients/concat_1/axis*
T0*

Tidx0*
N*
_output_shapes	
:�
�
gradients/AddN_2AddN0gradients/loss/pow_grad/tuple/control_dependency0gradients/loss/mul_grad/tuple/control_dependency*
T0*
_output_shapes
:	�
*
N*2
_class(
&$loc:@gradients/loss/pow_grad/Reshape
�
gradients/loss/users_grad/ShapeConst*)
_class
loc:@variables/user_factors*
_output_shapes
:*
dtype0*
valueB"  
   
a
gradients/loss/users_grad/SizeConst*
_output_shapes
: *
dtype0*
value
B :�
j
(gradients/loss/users_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
$gradients/loss/users_grad/ExpandDims
ExpandDimsgradients/loss/users_grad/Size(gradients/loss/users_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:
w
-gradients/loss/users_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
y
/gradients/loss/users_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
y
/gradients/loss/users_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
'gradients/loss/users_grad/strided_sliceStridedSlicegradients/loss/users_grad/Shape-gradients/loss/users_grad/strided_slice/stack/gradients/loss/users_grad/strided_slice/stack_1/gradients/loss/users_grad/strided_slice/stack_2*
Index0*
shrink_axis_mask *
end_mask*
new_axis_mask *
ellipsis_mask *

begin_mask *
T0*
_output_shapes
:
g
%gradients/loss/users_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
 gradients/loss/users_grad/concatConcatV2$gradients/loss/users_grad/ExpandDims'gradients/loss/users_grad/strided_slice%gradients/loss/users_grad/concat/axis*
T0*

Tidx0*
N*
_output_shapes
:
�
!gradients/loss/users_grad/ReshapeReshapegradients/AddN_2 gradients/loss/users_grad/concat*
T0*
Tshape0*0
_output_shapes
:������������������
�
#gradients/loss/users_grad/Reshape_1Reshapeplaceholders/sampled_users$gradients/loss/users_grad/ExpandDims*
T0*
Tshape0*
_output_shapes	
:�
n
gradients/loss/sub_grad/ShapeConst*
_output_shapes
:*
dtype0*
valueB"�   
   
p
gradients/loss/sub_grad/Shape_1Const*
_output_shapes
:*
dtype0*
valueB"�   
   
�
-gradients/loss/sub_grad/BroadcastGradientArgsBroadcastGradientArgsgradients/loss/sub_grad/Shapegradients/loss/sub_grad/Shape_1*
T0*2
_output_shapes 
:���������:���������
�
gradients/loss/sub_grad/SumSum2gradients/loss/mul_grad/tuple/control_dependency_1-gradients/loss/sub_grad/BroadcastGradientArgs*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
�
gradients/loss/sub_grad/ReshapeReshapegradients/loss/sub_grad/Sumgradients/loss/sub_grad/Shape*
T0*
Tshape0*
_output_shapes
:	�

�
gradients/loss/sub_grad/Sum_1Sum2gradients/loss/mul_grad/tuple/control_dependency_1/gradients/loss/sub_grad/BroadcastGradientArgs:1*
T0*

Tidx0*
_output_shapes
:*
	keep_dims( 
d
gradients/loss/sub_grad/NegNeggradients/loss/sub_grad/Sum_1*
T0*
_output_shapes
:
�
!gradients/loss/sub_grad/Reshape_1Reshapegradients/loss/sub_grad/Neggradients/loss/sub_grad/Shape_1*
T0*
Tshape0*
_output_shapes
:	�

v
(gradients/loss/sub_grad/tuple/group_depsNoOp ^gradients/loss/sub_grad/Reshape"^gradients/loss/sub_grad/Reshape_1
�
0gradients/loss/sub_grad/tuple/control_dependencyIdentitygradients/loss/sub_grad/Reshape)^gradients/loss/sub_grad/tuple/group_deps*
T0*
_output_shapes
:	�
*2
_class(
&$loc:@gradients/loss/sub_grad/Reshape
�
2gradients/loss/sub_grad/tuple/control_dependency_1Identity!gradients/loss/sub_grad/Reshape_1)^gradients/loss/sub_grad/tuple/group_deps*
T0*
_output_shapes
:	�
*4
_class*
(&loc:@gradients/loss/sub_grad/Reshape_1
�
gradients/AddN_3AddN2gradients/loss/pow_1_grad/tuple/control_dependency0gradients/loss/sub_grad/tuple/control_dependency*
T0*
_output_shapes
:	�
*
N*4
_class*
(&loc:@gradients/loss/pow_1_grad/Reshape
�
#gradients/loss/pos_items_grad/ShapeConst*)
_class
loc:@variables/item_factors*
_output_shapes
:*
dtype0*
valueB"m  
   
e
"gradients/loss/pos_items_grad/SizeConst*
_output_shapes
: *
dtype0*
value
B :�
n
,gradients/loss/pos_items_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
(gradients/loss/pos_items_grad/ExpandDims
ExpandDims"gradients/loss/pos_items_grad/Size,gradients/loss/pos_items_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:
{
1gradients/loss/pos_items_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
}
3gradients/loss/pos_items_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
}
3gradients/loss/pos_items_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
+gradients/loss/pos_items_grad/strided_sliceStridedSlice#gradients/loss/pos_items_grad/Shape1gradients/loss/pos_items_grad/strided_slice/stack3gradients/loss/pos_items_grad/strided_slice/stack_13gradients/loss/pos_items_grad/strided_slice/stack_2*
Index0*
shrink_axis_mask *
end_mask*
new_axis_mask *
ellipsis_mask *

begin_mask *
T0*
_output_shapes
:
k
)gradients/loss/pos_items_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
$gradients/loss/pos_items_grad/concatConcatV2(gradients/loss/pos_items_grad/ExpandDims+gradients/loss/pos_items_grad/strided_slice)gradients/loss/pos_items_grad/concat/axis*
T0*

Tidx0*
N*
_output_shapes
:
�
%gradients/loss/pos_items_grad/ReshapeReshapegradients/AddN_3$gradients/loss/pos_items_grad/concat*
T0*
Tshape0*0
_output_shapes
:������������������
�
'gradients/loss/pos_items_grad/Reshape_1Reshapeplaceholders/sampled_pos_items(gradients/loss/pos_items_grad/ExpandDims*
T0*
Tshape0*
_output_shapes	
:�
�
gradients/AddN_4AddN2gradients/loss/pow_3_grad/tuple/control_dependency2gradients/loss/sub_grad/tuple/control_dependency_1*
T0*
_output_shapes
:	�
*
N*4
_class*
(&loc:@gradients/loss/pow_3_grad/Reshape
�
#gradients/loss/neg_items_grad/ShapeConst*)
_class
loc:@variables/item_factors*
_output_shapes
:*
dtype0*
valueB"m  
   
e
"gradients/loss/neg_items_grad/SizeConst*
_output_shapes
: *
dtype0*
value
B :�
n
,gradients/loss/neg_items_grad/ExpandDims/dimConst*
_output_shapes
: *
dtype0*
value	B : 
�
(gradients/loss/neg_items_grad/ExpandDims
ExpandDims"gradients/loss/neg_items_grad/Size,gradients/loss/neg_items_grad/ExpandDims/dim*
T0*

Tdim0*
_output_shapes
:
{
1gradients/loss/neg_items_grad/strided_slice/stackConst*
_output_shapes
:*
dtype0*
valueB:
}
3gradients/loss/neg_items_grad/strided_slice/stack_1Const*
_output_shapes
:*
dtype0*
valueB: 
}
3gradients/loss/neg_items_grad/strided_slice/stack_2Const*
_output_shapes
:*
dtype0*
valueB:
�
+gradients/loss/neg_items_grad/strided_sliceStridedSlice#gradients/loss/neg_items_grad/Shape1gradients/loss/neg_items_grad/strided_slice/stack3gradients/loss/neg_items_grad/strided_slice/stack_13gradients/loss/neg_items_grad/strided_slice/stack_2*
Index0*
shrink_axis_mask *
end_mask*
new_axis_mask *
ellipsis_mask *

begin_mask *
T0*
_output_shapes
:
k
)gradients/loss/neg_items_grad/concat/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
$gradients/loss/neg_items_grad/concatConcatV2(gradients/loss/neg_items_grad/ExpandDims+gradients/loss/neg_items_grad/strided_slice)gradients/loss/neg_items_grad/concat/axis*
T0*

Tidx0*
N*
_output_shapes
:
�
%gradients/loss/neg_items_grad/ReshapeReshapegradients/AddN_4$gradients/loss/neg_items_grad/concat*
T0*
Tshape0*0
_output_shapes
:������������������
�
'gradients/loss/neg_items_grad/Reshape_1Reshapeplaceholders/sampled_neg_items(gradients/loss/neg_items_grad/ExpandDims*
T0*
Tshape0*
_output_shapes	
:�
Y
gradients/concat_2/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients/concat_2ConcatV2%gradients/loss/pos_items_grad/Reshape%gradients/loss/neg_items_grad/Reshapegradients/concat_2/axis*
T0*

Tidx0*
N*0
_output_shapes
:������������������
Y
gradients/concat_3/axisConst*
_output_shapes
: *
dtype0*
value	B : 
�
gradients/concat_3ConcatV2'gradients/loss/pos_items_grad/Reshape_1'gradients/loss/neg_items_grad/Reshape_1gradients/concat_3/axis*
T0*

Tidx0*
N*
_output_shapes	
:�
b
GradientDescent/learning_rateConst*
_output_shapes
: *
dtype0*
valueB
 *���=
�
1GradientDescent/update_variables/user_factors/mulMul!gradients/loss/users_grad/ReshapeGradientDescent/learning_rate*
T0*0
_output_shapes
:������������������*)
_class
loc:@variables/user_factors
�
8GradientDescent/update_variables/user_factors/ScatterSub
ScatterSubvariables/user_factors#gradients/loss/users_grad/Reshape_11GradientDescent/update_variables/user_factors/mul*
T0*
_output_shapes
:	�
*)
_class
loc:@variables/user_factors*
Tindices0*
use_locking( 
�
1GradientDescent/update_variables/item_factors/mulMulgradients/concat_2GradientDescent/learning_rate*
T0*0
_output_shapes
:������������������*)
_class
loc:@variables/item_factors
�
8GradientDescent/update_variables/item_factors/ScatterSub
ScatterSubvariables/item_factorsgradients/concat_31GradientDescent/update_variables/item_factors/mul*
T0*
_output_shapes
:	�
*)
_class
loc:@variables/item_factors*
Tindices0*
use_locking( 
�
.GradientDescent/update_variables/item_bias/mulMulgradients/concatGradientDescent/learning_rate*
T0*
_output_shapes	
:�*&
_class
loc:@variables/item_bias
�
5GradientDescent/update_variables/item_bias/ScatterSub
ScatterSubvariables/item_biasgradients/concat_1.GradientDescent/update_variables/item_bias/mul*
T0*
_output_shapes	
:�*&
_class
loc:@variables/item_bias*
Tindices0*
use_locking( 
�
GradientDescentNoOp9^GradientDescent/update_variables/user_factors/ScatterSub9^GradientDescent/update_variables/item_factors/ScatterSub6^GradientDescent/update_variables/item_bias/ScatterSub
R
loss_1/tagsConst*
_output_shapes
: *
dtype0*
valueB Bloss_1
Q
loss_1ScalarSummaryloss_1/tags
loss/sub_2*
T0*
_output_shapes
: 
K
Merge/MergeSummaryMergeSummaryloss_1*
_output_shapes
: *
N
i
initNoOp^variables/user_factors/Assign^variables/item_factors/Assign^variables/item_bias/Assign""
	summaries


loss_1:0"�
trainable_variables��
X
variables/user_factors:0variables/user_factors/Assignvariables/user_factors/read:0
X
variables/item_factors:0variables/item_factors/Assignvariables/item_factors/read:0
O
variables/item_bias:0variables/item_bias/Assignvariables/item_bias/read:0"�
	variables��
X
variables/user_factors:0variables/user_factors/Assignvariables/user_factors/read:0
X
variables/item_factors:0variables/item_factors/Assignvariables/item_factors/read:0
O
variables/item_bias:0variables/item_bias/Assignvariables/item_bias/read:0"
train_op

GradientDescent���       ��-	
��Q�^�A*

loss_1`�C�2�r       ���	���Q�^�A*

loss_1��C��R       ���	���Q�^�A*

loss_1�C��I�       ���	���Q�^�A*

loss_1$CA�       ���	Φ�Q�^�A*

loss_1#C���       ���	Q��Q�^�A*

loss_1��C�7=�       ���	��Q�^�A*

loss_1�C�Lp       ���	��Q�^�A*

loss_1
CZ�a�       ���	���Q�^�A*

loss_1��C?�$~       ���	qs�Q�^�A	*

loss_1��C}~D�       ���	�J�Q�^�A
*

loss_1y�C���       ���	?�Q�^�A*

loss_1ECزE�       ���	�$�Q�^�A*

loss_1�Ck��l       ���	j��Q�^�A*

loss_1#�C6]e       ���	���Q�^�A*

loss_1��
C�r       ���	���Q�^�A*

loss_1��C��       ���	���Q�^�A*

loss_1'��Bɥ�k       ���	Kr�Q�^�A*

loss_1�`C�BQ�       ���	�K�Q�^�A*

loss_1:SCV�       ���	��Q�^�A*

loss_114C��       ���	���Q�^�A*

loss_1��B�Y�       ���	��Q�^�A*

loss_1�1C���+       ���	B��Q�^�A*

loss_1�C���       ���	�t�Q�^�A*

loss_1� C��#�       ���	#i�Q�^�A*

loss_1B�C�R�       ���	tF�Q�^�A*

loss_1ZC��       ���	��Q�^�A*

loss_1=��B$Z{       ���	���Q�^�A*

loss_1���B��)       ���	*��Q�^�A*

loss_1{C_�3�       ���	5��Q�^�A*

loss_1#� C��fL       ���	�g�Q�^�A*

loss_1�CI}��       ���	|D�Q�^�A*

loss_1I<�B��       ���	2�Q�^�A *

loss_17��Bv���       ���	"�Q�^�A!*

loss_1I<�B����       ���	���Q�^�A"*

loss_1���Bc_9�       ���	���Q�^�A#*

loss_1�m�B��Q�       ���	���Q�^�A$*

loss_1| �BFj�       ���	�n�Q�^�A%*

loss_1���B�o��       ���	=�Q�^�A&*

loss_1���BeԔ       ���	��Q�^�A'*

loss_1�H�B���       ���	V��Q�^�A(*

loss_1TS�B^�[&       ���	���Q�^�A)*

loss_144�Bs��       ���	���Q�^�A**

loss_1y��B'��       ���	4��Q�^�A+*

loss_1`��Bץ�w       ���	�V�Q�^�A,*

loss_1��B��{       ���	R(�Q�^�A-*

loss_1��B_g5       ���	n��Q�^�A.*

loss_1� �B�c��       ���	)��Q�^�A/*

loss_1��B�2�       ���	h��Q�^�A0*

loss_1�D�Bg���       ���	���Q�^�A1*

loss_1���B�f2�       ���	���Q�^�A2*

loss_1�B��#�       ���	��Q�^�A3*

loss_1��BG���       ���	�~�Q�^�A4*

loss_1r	�B2x��       ���	�K�Q�^�A5*

loss_1�#�BX�       ���	�)�Q�^�A6*

loss_1*t�Be�aS       ���	��Q�^�A7*

loss_1���B�y�       ���	��Q�^�A8*

loss_1Ҩ�B��       ���	��Q�^�A9*

loss_1Z�BQ�p       ���	f��Q�^�A:*

loss_1<��B\�r       ���	5��Q�^�A;*

loss_1Ҋ�B��r�       ���	���Q�^�A<*

loss_1���BZˊ�       ���	�r�Q�^�A=*

loss_1m�B�E�       ���	#N�Q�^�A>*

loss_1l�B��}       ���	1�Q�^�A?*

loss_1b7�BĊR�       ���	�- R�^�A@*

loss_1���B�f}[       ���	sR�^�AA*

loss_1�B4o�3       ���	Z�R�^�AB*

loss_1���BD��R       ���	��R�^�AC*

loss_1�Z�B�c�"       ���	w�R�^�AD*

loss_1���BJ)       ���	�rR�^�AE*

loss_1���B�	>       ���	�JR�^�AF*

loss_1a��BC���       ���	C R�^�AG*

loss_1��BM��       ���	�
R�^�AH*

loss_1��B|���       ���	��R�^�AI*

loss_1ߟ�B0��       ���	q�R�^�AJ*

loss_1���BVw       ���	/�	R�^�AK*

loss_14�B�ô       ���	Wy
R�^�AL*

loss_1��B�� �       ���	XR�^�AM*

loss_1���Bg���       ���	)"R�^�AN*

loss_1$�B�O       ���	;�R�^�AO*

loss_1�[�B���:       ���	,�R�^�AP*

loss_1���B%���       ���	��R�^�AQ*

loss_1��BI�J�       ���	?�R�^�AR*

loss_1C��B��k       ���	�R�^�AS*

loss_1�ҷB��h       ���	�PR�^�AT*

loss_1a"�B�L�       ���	`!R�^�AU*

loss_1�]�BV��        ���	��R�^�AV*

loss_1�̲B���       ���	��R�^�AW*

loss_1_@�B$�Zd       ���	˽R�^�AX*

loss_1�V�B��*       ���	 �R�^�AY*

loss_1ļB��B       ���	WzR�^�AZ*

loss_1��BF|�       ���	rRR�^�A[*

loss_1��B��*       ���	o)R�^�A\*

loss_1�>�BP,��       ���	��R�^�A]*

loss_1�l�B�g�       ���	!�R�^�A^*

loss_1���B��@0       ���	J�R�^�A_*

loss_1���B��c�       ���	�R�^�A`*

loss_1(g�B��ܻ       ���	�fR�^�Aa*

loss_1=��B`�       ���	�@R�^�Ab*

loss_1���B3}��       ���	�R�^�Ac*

loss_1�P�BxX<e       ���	2�R�^�Ad*

loss_1Y�B[e�s       ���	�R�^�Ae*

loss_1���B}�l       ���	%� R�^�Af*

loss_1a*�BP��i       ���	sh!R�^�Ag*

loss_1���B�/��       ���	S"R�^�Ah*

loss_16x�B�	�@       ���	A-#R�^�Ai*

loss_1[�B��<       ���	�$R�^�Aj*

loss_1�֝B1��       ���	��$R�^�Ak*

loss_1h��B�ֻ�       ���	��%R�^�Al*

loss_1��Bo�	�       ���	f�&R�^�Am*

loss_1B�B��r$       ���	�g'R�^�An*

loss_1���B"��C       ���	m<(R�^�Ao*

loss_1��BI�"       ���	V))R�^�Ap*

loss_1*�B7��H       ���	1
*R�^�Aq*

loss_1��Bf�MU       ���	T�*R�^�Ar*

loss_1�͚B
�t       ���	{�+R�^�As*

loss_1��B�6�|       ���	2�,R�^�At*

loss_1F�BZ��:       ���	�^-R�^�Au*

loss_1G�B�.0       ���	?.R�^�Av*

loss_1%��Bx���       ���	3/R�^�Aw*

loss_1?��B�I       ���	�0R�^�Ax*

loss_1牘B����       ���	m�0R�^�Ay*

loss_1u��B���       ���	��1R�^�Az*

loss_1Ѭ�Bw��       ���	��2R�^�A{*

loss_1ǒ�B<�Y       ���	��3R�^�A|*

loss_1,"�B�'�       ���	X4R�^�A}*

loss_1e��B��       ���	�$5R�^�A~*

loss_1Q��B;B�       ���	6R�^�A*

loss_1�ҊBL;�9       `/�#	X7R�^�A�*

loss_1��B*=|[       `/�#	�7R�^�A�*

loss_15��B�5u       `/�#	��8R�^�A�*

loss_1�_�B���       `/�#	��9R�^�A�*

loss_1D�Bf��       `/�#	V:R�^�A�*

loss_11�B�=��       `/�#	=(;R�^�A�*

loss_1H6�B+
e�       `/�#	(
<R�^�A�*

loss_1լ�B�_�       `/�#	��<R�^�A�*

loss_1h�B�_�a       `/�#	�=R�^�A�*

loss_1ּ�B�A�T       `/�#	C�>R�^�A�*

loss_1:�B�ֳ       `/�#	a�?R�^�A�*

loss_1�1�B1��^       `/�#	`v@R�^�A�*

loss_1��xB��m       `/�#	�OAR�^�A�*

loss_1ՓB�)�       `/�#	CBR�^�A�*

loss_1C��B��       `/�#	�BR�^�A�*

loss_1��~BAe�#       `/�#	��CR�^�A�*

loss_1�4wBɬ�#       `/�#	h�DR�^�A�*

loss_1Y�Ba�       `/�#	�ER�^�A�*

loss_1JxBB��       `/�#	)�FR�^�A�*

loss_1���B<�       `/�#	pwGR�^�A�*

loss_14J�B�}:�       `/�#	GHR�^�A�*

loss_1@V�B���p       `/�#	�!IR�^�A�*

loss_1캌B���