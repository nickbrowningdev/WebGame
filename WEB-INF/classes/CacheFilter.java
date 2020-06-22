package game;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;
import javax.servlet.annotation.WebFilter;

@WebFilter(urlPatterns = {"*.jsp"})
public class CacheFilter implements Filter 
{

    public CacheFilter() 
    {

	}

    public void destroy() 
    {
		
	}

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException 
    {
		HttpServletResponse res = (HttpServletResponse) response;

		res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
		res.setHeader("Pragma", "no-cache"); // HTTP 1.0.
		res.setDateHeader("Expires", 0); // Proxies.

		chain.doFilter(request, response);
	}

    public void init(FilterConfig fConfig) throws ServletException 
    {

	}

}