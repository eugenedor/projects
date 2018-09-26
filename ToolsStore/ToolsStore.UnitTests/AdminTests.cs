﻿using System;
using System.Text;
using System.Collections.Generic;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using ToolsStore.Domain.Abstract;
using ToolsStore.Domain.Entities;
using ToolsStore.WebUI.Controllers;
using System.Linq;
using System.Web.Mvc;

namespace ToolsStore.UnitTests
{
    [TestClass]
    public class AdminTests
    {
        [TestMethod]
        public void Index_Contains_All_LoadRules()
        {
            // Arrange - create the mock repository
            Mock<IRuleRepository> mock = new Mock<IRuleRepository>();
            mock.Setup(m => m.LoadRules).Returns(new MT_LOAD_RULE[] {
                new MT_LOAD_RULE {LoadRuleId = 1, Code = "LR1"},
                new MT_LOAD_RULE {LoadRuleId = 2, Code = "LR2"},
                new MT_LOAD_RULE {LoadRuleId = 3, Code = "LR3"},
            }.AsQueryable());
            // Arrange - create a controller
            AdminController target = new AdminController(mock.Object);
            // Action
            MT_LOAD_RULE[] result = ((IEnumerable<MT_LOAD_RULE>)target.Index().ViewData.Model).ToArray();
            // Assert
            Assert.AreEqual(result.Length, 3);
            Assert.AreEqual("LR1", result[0].Code);
            Assert.AreEqual("LR2", result[1].Code);
            Assert.AreEqual("LR3", result[2].Code);
        }

        [TestMethod]
        public void Can_Edit_LoadRule()
        {
            // Arrange - create the mock repository
            Mock<IRuleRepository> mock = new Mock<IRuleRepository>();
            mock.Setup(m => m.LoadRules).Returns(new MT_LOAD_RULE[] {
                new MT_LOAD_RULE {LoadRuleId = 1, Code = "LR1"},
                new MT_LOAD_RULE {LoadRuleId = 2, Code = "LR2"},
                new MT_LOAD_RULE {LoadRuleId = 3, Code = "LR3"},
            }.AsQueryable());
            // Arrange - create the controller
            AdminController target = new AdminController(mock.Object);
            // Act
            MT_LOAD_RULE p1 = target.Edit(1).ViewData.Model as MT_LOAD_RULE;
            MT_LOAD_RULE p2 = target.Edit(2).ViewData.Model as MT_LOAD_RULE;
            MT_LOAD_RULE p3 = target.Edit(3).ViewData.Model as MT_LOAD_RULE;
            // Assert
            Assert.AreEqual(1, p1.LoadRuleId);
            Assert.AreEqual(2, p2.LoadRuleId);
            Assert.AreEqual(3, p3.LoadRuleId);
        }

        [TestMethod]
        public void Cannot_Edit_Nonexistent_LoadRule()
        {
            // Arrange - create the mock repository
            Mock<IRuleRepository> mock = new Mock<IRuleRepository>();
            mock.Setup(m => m.LoadRules).Returns(new MT_LOAD_RULE[] {
                new MT_LOAD_RULE {LoadRuleId = 1, Code = "LR1"},
                new MT_LOAD_RULE {LoadRuleId = 2, Code = "LR2"},
                new MT_LOAD_RULE {LoadRuleId = 3, Code = "LR3"},
            }.AsQueryable());
            // Arrange - create the controller
            AdminController target = new AdminController(mock.Object);
            // Act
            MT_LOAD_RULE result = (MT_LOAD_RULE)target.Edit(4).ViewData.Model;
            // Assert
            Assert.IsNull(result);
        }

        [TestMethod]
        public void Can_Save_Valid_Changes()
        {
            // Arrange - create mock repository
            Mock<IRuleRepository> mock = new Mock<IRuleRepository>();
            // Arrange - create the controller
            AdminController target = new AdminController(mock.Object);
            // Arrange - create a loadRule
            MT_LOAD_RULE loadRule = new MT_LOAD_RULE { Code = "Test" };
            // Act - try to save the loadRule
            ActionResult result = target.Edit(loadRule);
            // Assert - check that the repository was called
            mock.Verify(m => m.SaveLoadRule(loadRule));
            // Assert - check the method result type
            Assert.IsNotInstanceOfType(result, typeof(ViewResult));
        }

        [TestMethod]
        public void Cannot_Save_Invalid_Changes()
        {
            // Arrange - create mock repository
            Mock<IRuleRepository> mock = new Mock<IRuleRepository>();
            // Arrange - create the controller
            AdminController target = new AdminController(mock.Object);
            // Arrange - create a loadRule
            MT_LOAD_RULE loadRule = new MT_LOAD_RULE { Code = "Test" };
            // Arrange - add an error to the model state
            target.ModelState.AddModelError("error", "error");
            // Act - try to save the loadRule
            ActionResult result = target.Edit(loadRule);
            // Assert - check that the repository was not called
            mock.Verify(m => m.SaveLoadRule(It.IsAny<MT_LOAD_RULE>()), Times.Never());
            // Assert - check the method result type
            Assert.IsInstanceOfType(result, typeof(ViewResult));
        }

        [TestMethod]
        public void Can_Delete_Valid_LoadRules()
        {
            // Arrange - create a Product
            MT_LOAD_RULE loadRule = new MT_LOAD_RULE { LoadRuleId = 2, Code = "Test" };
            // Arrange - create the mock repository
            Mock<IRuleRepository> mock = new Mock<IRuleRepository>();
            mock.Setup(m => m.LoadRules).Returns(new MT_LOAD_RULE[] {
                new MT_LOAD_RULE {LoadRuleId = 1, Code = "LR1"},
                loadRule,
                new MT_LOAD_RULE {LoadRuleId = 3, Code = "LR3"},
            }.AsQueryable());
            // Arrange - create the controller
            AdminController target = new AdminController(mock.Object);
            // Act - delete the product
            target.Delete(loadRule.LoadRuleId);
            // Assert - ensure that the repository delete method was
            // called with the correct Product
            mock.Verify(m => m.DeleteLoadRule(loadRule.LoadRuleId));
        }
    }
}
