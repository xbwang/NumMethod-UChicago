%method 1, with built in function spline
function p3(N) % N should be data values array
	n = length(N);
	x = -(n-1)/2 : (n-1)/2;
	s = spline(x, [0 N 0]);
	xx = linspace(-(n-1)/2, (n-1)/2, 101);
	s.coefs
	plot(x, N, 'o', xx, ppval(s, xx), '-');
end