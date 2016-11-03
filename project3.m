% Domino Arm
% This is the main document code that controls all the functions

%% Setup
close all;
clear all;

colorDevice = imaq.VideoDevice('kinect',1);

%% Get Background Image
backImage = step(colorDevice);

%% Code
while 1
    %Move the arm to a position that is outside the visible workspace
    resetArm();
    
    %Get current map of objects and dominos in scene
    Map = GetMap(backImage, colorDevice);
    
    %Detect Dominos and store in domino array
    DominoInfo = Domino_Detection(step(colorDevice));

    %Find which domino to move and where
    %Loop through array of dominos and determine which dominos can be moved
    %to their sorted location.
    for i = 1:size(DominoInfo, 1)
        goal_L = DominoInfo(i, :).goal_location;
        current_L = DominoInfo(i, :).current_location;
        Path = GreedSearch(Map, goal_L, current_L);
        
        %Only move domino if it is not already at its goal location
        if (~DominoInfo(i, :).moved)
            
            %Greed search returns a blank path if there is no possible path to
              %the goal location
            %If path is not empty, command arm to move domino
            if (~isempty(Path))

                %Function for moving domino to goal location
                MoveDomino(Path);

            end
        end
    end
      
    
%     %Create Map
%     Map = GetMap(backImage, colorDevice);
%     Map = imgaussfilt(Map, 3);
%     Map = im2bw(Map, 0.25);
%     
%     %solve for path
%     Path = GreedSearch(Map, startLocation, endLocation);
%     
%     %operate actuator
    
    
end
