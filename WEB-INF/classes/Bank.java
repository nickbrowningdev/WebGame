
//calculations made for the game

package game;

import java.util.*;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Bank extends HttpServlet
{
    public Bank() 
    {
		super();
	}

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {
		response.sendRedirect(request.getContextPath());
	}

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    {

		HttpSession session = request.getSession();

		double totalAmount = 0, maxAmount = 0, bankOffer = 0;

		GameBean gameBean = (GameBean) session.getAttribute("gameBean");

        if(gameBean != null) 
        {
			Briefcase[] briefcaseList = gameBean.getBriefcaseList();

			int i = 0;
            for(Briefcase briefcase : briefcaseList) 
            {
                if (!briefcase.isRevealed()) 
                {
					// amount from remaining cases
					totalAmount += briefcase.getAmount();
					i++;
					
					// finds max amount
                    if(briefcase.getAmount() > maxAmount) 
                    {
						maxAmount = briefcase.getAmount();
					}
				}
			}
			
			bankOffer = Math.round((totalAmount/i) * 100.0) / 100.0;
			
			session.setAttribute("bankOffer", bankOffer);
			session.setAttribute("maxAmount", maxAmount);

			response.sendRedirect("/c3302779_assignment2/bank.jsp");
			
		} else {
			session.setAttribute("gameError", "An error occured, please try again.");
			response.sendRedirect(request.getContextPath());
		}
	}
}