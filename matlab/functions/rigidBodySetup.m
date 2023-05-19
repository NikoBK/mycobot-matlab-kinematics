function output = rigidBodySetup()
    % Setting up the robot rigidbody tree.
    cobot = rigidBodyTree;
    
    body1 = rigidBody('link1');
    jnt1 = rigidBodyJoint('joint2_to_joint1','revolute');
    body2 = rigidBody('link2');
    jnt2 = rigidBodyJoint('joint3_to_joint2','revolute');
    body3 = rigidBody('link3');
    jnt3 = rigidBodyJoint('joint4_to_joint2','revolute');
    body4 = rigidBody('link4');
    jnt4 = rigidBodyJoint('joint5_to_joint3','revolute');
    body5 = rigidBody('link5');
    jnt5 = rigidBodyJoint('joint6_to_joint4','revolute');
    body6 = rigidBody('link6');
    jnt6 = rigidBodyJoint('joint6output_to_joint6','revolute');
    
    setFixedTransform(jnt1, dhParams_Test(1,:), 'mdh');
    setFixedTransform(jnt2, dhParams_Test(2,:), 'mdh');
    setFixedTransform(jnt3, dhParams_Test(3,:), 'mdh');
    setFixedTransform(jnt4, dhParams_Test(4,:), 'mdh');
    setFixedTransform(jnt5, dhParams_Test(5,:), 'mdh');
    setFixedTransform(jnt6, dhParams_Test(6,:), 'mdh');
    
    jnt1.HomePosition = 0;
    body1.Joint = jnt1;
    addBody(cobot, body1, 'base')
    
    jnt2.HomePosition = pi/2;
    body2.Joint = jnt2;
    addBody(cobot, body2, 'link1')
    
    jnt3.HomePosition = 0;
    body3.Joint = jnt3;
    addBody(cobot, body3, 'link2')
    
    jnt4.HomePosition = 0;
    body4.Joint = jnt4;
    addBody(cobot, body4, 'link3')
    
    jnt5.HomePosition = 0;
    body5.Joint = jnt5;
    addBody(cobot, body5, 'link4')
    
    jnt6.HomePosition = 0;
    body6.Joint = jnt6;
    addBody(cobot, body6, 'link5')
    output = true;
end