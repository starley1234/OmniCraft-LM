$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: flanged bushing R24
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 4;               // bore radius
flange_r = 24;            // flange radius
flange_h = 5;             // flange thickness
sleeve_r = 12;            // sleeve radius
total_h = 24;             // overall height
revolve_angle = 360;      // revolve sweep, degrees

bore_d = 2 * bore_r;
flange_d = 2 * flange_r;
sleeve_d = 2 * sleeve_r;

profile = [[4, 0], [24, 0], [24, 5], [12, 5], [12, 24], [4, 24]];  // primary outline, 6 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
