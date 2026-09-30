$fn = 32;

// ----------------------------------------------------------------------
// Chain sprocket: 10 teeth, 26 mm root radius
// ----------------------------------------------------------------------

// --- parameters (mm) ---
profile_height = 10;      // extrusion height
profile_points = 20;      // points of the closed outline

profile = [[59.381, 28.764], [67.566, 37.152], [57.167, 44.68], [58.858, 56.276], [46.021, 56.255], [40.573, 66.63], [30.2, 59.067], [19.694, 64.259], [15.748, 52.043], [4.197, 50.068], [8.184, 37.866], [0, 29.478], [10.398, 21.95], [8.707, 10.354], [21.544, 10.375], [26.993, 0], [37.365, 7.563], [47.872, 2.371], [51.818, 14.587], [63.369, 16.562]];  // single closed polygon, 20 points, counter clockwise

// --- the one profile operation ---
linear_extrude(height = profile_height) polygon(points = profile);
