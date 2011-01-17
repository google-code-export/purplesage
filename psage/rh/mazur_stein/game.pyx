include 'interrupt.pxi'

from sage.finance.time_series cimport TimeSeries
from sage.stats.intlist cimport IntList

cdef extern:
    double log(double)
    double sqrt(double)
    double cos(double)
    double sin(double)

cdef class J:
    cdef long N_max
    cdef TimeSeries a, s
    cdef IntList pv
    
    def __init__(self, int N_max=10**5):
        from sage.all import prime_powers, factor
        self.N_max   = N_max
        PP = prime_powers(N_max+1)[1:]

        cdef double logp
        cdef int i, n  = len(PP)
        self.a   = TimeSeries(n)
        self.s   = TimeSeries(n)
        self.pv  = IntList(n)
        i = 0
        for pv in PP:
            F = factor(pv)
            p, v = F[0]
            self.pv._values[i] = pv
            logp = log(p)
            self.a._values[i] = logp/sqrt(pv)
            self.s._values[i] = v*logp
            i += 1

    def __repr__(self):
        return "The function J(t,N) of the Mazur-Stein game with N_Max=%s"%self.N_max

    cpdef double F(self, double t, int N):
        cdef double ans = 0
        cdef int i = 0
        if N > self.N_max:
            raise ValueError, "J not defined for N > %s"%self.N_max
        while 1:
            if self.pv._values[i] >= N:
                return ans
            ans += self.a._values[i] * cos(self.s._values[i]*t)
            i += 1
            
    cpdef double e(self, double t, int N):
        return sqrt(N)/(.25 + t*t) * \
               ( cos(t*log(N)) + 2*t*sin(t*log(N)) )

    cpdef double H(self, double t, int N):
        cdef double ans = 0, F = 0
        cdef int i = 0, n
        if N > self.N_max:
            raise ValueError, "J not defined for N > %s"%self.N_max
        n = 1
        _sig_on
        while 1:
            if self.pv._values[i] > N:
                # time to return.  But first we have to add a few more
                # values to ans up to N (where F is constant).
                while n <= N:
                    ans += F + self.e(t,n)
                    #print (n, F, self.e(t,n))
                    n += 1
                # Finally return after dividing by N.
                _sig_off                
                return ans / N
            # At this point, F is equal to self.F(t, self.pv._values[i]),
            # and now we add to our running total a range of values of

            #    F(t, n) + e(t,n)
            while n <= self.pv._values[i]:
                ans += F + self.e(t,n)
                #print (n, F, self.e(t,n))                
                n += 1

            F += self.a._values[i] * cos(self.s._values[i]*t)

            # move to next prime power
            i += 1

    cpdef double J(self, double t, int N):
        return self.H(t,N) / log(N)

    def __call__(self, double t, int N):
        return self.J(t,N)

    cpdef double H2(self, double t, int N):
        cdef int n
        return sum(self.F(t,n) + self.e(t,n) for n in range(1,N+1)) / N

    cpdef double J2(self, double t, int N):
        return self.H2(t, N) / log(N)

         
           

