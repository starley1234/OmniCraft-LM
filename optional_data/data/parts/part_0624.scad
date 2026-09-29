// Rectangular shaft key with chamfered ends.
$fn = 60;
eps = 0.02;
key_w = 10;
key_h = 8;
key_l = 40;
chamfer = 1;
polyhedron(points = [
    [-key_l / 2 + chamfer, -key_w / 2, 0], [key_l / 2 - chamfer, -key_w / 2, 0], [key_l / 2, key_w / 2, 0], [-key_l / 2, key_w / 2, 0],
    [-key_l / 2 + chamfer, -key_w / 2, key_h], [key_l / 2 - chamfer, -key_w / 2, key_h], [key_l / 2, key_w / 2, key_h], [-key_l / 2, key_w / 2, key_h]
], faces = [[0,1,2,3],[4,7,6,5],[0,4,5,1],[1,5,6,2],[2,6,7,3],[3,7,4,0]]);
