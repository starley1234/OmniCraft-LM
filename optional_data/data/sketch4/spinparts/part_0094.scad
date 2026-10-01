$fn = 32;

// ----------------------------------------------------------------------
// Revolved part: V-groove pulley R35
// ----------------------------------------------------------------------

// --- parameters (mm) ---
bore_r = 5;               // bore radius
rim_r = 35;               // rim radius
rim_t = 14;               // rim width
groove_r = 13;            // groove root radius
groove_w = 4;             // groove half width
revolve_angle = 360;      // revolve sweep, degrees

bore_d = 2 * bore_r;
rim_d = 2 * rim_r;
groove_d = 2 * groove_r;

profile = [[5, 0], [35, 0], [35, 3], [13, 7], [35, 11], [35, 14], [5, 14]];  // primary outline, 7 points, counter clockwise

// --- the one profile operation ---
rotate_extrude(angle = revolve_angle) polygon(points = profile);
