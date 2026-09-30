$fn = 32;

// ----------------------------------------------------------------------
// Cam disc: base radius 15.0 mm, lift 4.0 mm, 20 profile points
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 14;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[34, 15.605], [33.661, 20.369], [32.274, 25.249], [29.34, 29.837], [24.743, 33.279], [19, 34.605], [13.095, 33.78], [5.732, 33.866], [0.738, 28.873], [0.825, 21.51], [0, 15.605], [0.93, 9.734], [3.965, 4.682], [8.66, 1.373], [13.93, 0], [19, 0.189], [23.635, 1.339], [27.817, 3.47], [31.135, 6.788], [33.266, 10.97]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
