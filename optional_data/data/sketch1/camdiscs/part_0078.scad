$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 15.0 mm, lift 6.0 mm, 20 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[36, 18.001], [35.405, 22.681], [33.599, 27.154], [30.544, 31.136], [26.276, 34.238], [21, 36.001], [15.151, 36.001], [9.383, 33.99], [4.474, 30.007], [1.167, 24.445], [0, 18.001], [1.167, 11.557], [4.474, 5.994], [9.383, 2.012], [15.151, 0], [21, 0.001], [26.276, 1.763], [30.544, 4.865], [33.599, 8.847], [35.405, 13.32]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
