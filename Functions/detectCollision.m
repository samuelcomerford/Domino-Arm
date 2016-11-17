function Failed = detectCollision(Node, Map, Pose)
%detectCollision Summary of this function goes here
%   Detailed explanation goes here

Map_Size = size(Map);

% figure;
% imshow(Map);
% hold on;

height = 5;
width = 5;

point1_x = Node(2)-0.5*width*cos(Pose)-0.5*height*sin(Pose);
point1_y = Node(1)+0.5*width*sin(Pose)-0.5*height*cos(Pose);
point2_x = Node(2)+0.5*width*cos(Pose)-0.5*height*sin(Pose);
point2_y = Node(1)-0.5*width*sin(Pose)-0.5*height*cos(Pose);
point3_x = Node(2)+0.5*width*cos(Pose)+0.5*height*sin(Pose);
point3_y = Node(1)-0.5*width*sin(Pose)+0.5*height*cos(Pose);
point4_x = Node(2)-0.5*width*cos(Pose)+0.5*height*sin(Pose);
point4_y = Node(1)+0.5*width*sin(Pose)+0.5*height*cos(Pose);

x1 = [point1_x, point2_x, point3_x, point4_x, point1_x];
y1 = [point1_y, point2_y, point3_y, point4_y, point1_y];

% plot(y1, x1);


current_domino_mask = poly2mask(double(x1), double(y1), Map_Size(1), Map_Size(2));
new_map = current_domino_mask.*imcomplement(Map);

cropD = round(sqrt(width^2+height^2)/2);
objects= find(new_map( Node(1)-cropD:Node(1)+cropD, Node(2)-cropD:Node(2)+cropD ) ,1);

if( isempty(objects))
    Failed = 0;
else
    Failed = 1;
end

end



% %Create polygon around current pixel
% height = 56;
% width = 110;
% 
% map_crop = imcrop(Map, [Node(2)-width/2, Node(1)-height/2, width, height]);
% 
% for i = 1:size(map_crop, 1)
%     for j = 1:size(map_crop, 2)
%         if (map_crop(i,j) == 0)
%             Failed = 1;
%             return
%         end
%     end
% end
% 
% Failed = 0;

